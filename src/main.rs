mod db;
mod error;
mod models;
mod routes;
mod state;

use axum::{
    routing::{get},
    Router,
};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;
use tower_http::cors::CorsLayer;
use tower_http::trace::TraceLayer;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

use crate::state::AppState;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    dotenvy::dotenv().ok();

    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new(
            std::env::var("RUST_LOG").unwrap_or_else(|_| "electrician_index_rs=debug,tower_http=debug".into()),
        ))
        .with(tracing_subscriber::fmt::layer())
        .init();

    let db_url = std::env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set");

    let pool = PgPoolOptions::new()
        .max_connections(50)
        .min_connections(5)
        .connect(&db_url)
        .await?;

    // Run migrations
    sqlx::migrate!("./migrations")
        .run(&pool)
        .await?;

    let state = Arc::new(AppState { db: pool });

    let app = Router::new()
        .route("/health", get(routes::health::health_check))
        .route("/api/electricians", get(routes::electricians::search_electricians).post(routes::electricians::create_electrician))
        .route("/api/electricians/:id", get(routes::electricians::get_electrician))
        .layer(TraceLayer::new_for_http())
        .layer(CorsLayer::very_permissive())
        .with_state(state);

    let addr = std::net::SocketAddr::from(([0, 0, 0, 0], 8765));
    tracing::info!("→ Electrician Index online @ http://{}", addr);
    
    let listener = tokio::net::TcpListener::bind(addr).await?;
    axum::serve(listener, app).await?;

    Ok(())
}
