use axum::{
    extract::{Path, Query, State},
    Json,
};
use sqlx::{Postgres, QueryBuilder};
use std::sync::Arc;
use validator::Validate;

use crate::db::queries;
use crate::error::AppError;
use crate::models::{CreateElectrician, Electrician, SearchQuery};
use crate::state::AppState;

pub async fn search_electricians(
    State(state): State<Arc<AppState>>,
    Query(q): Query<SearchQuery>,
) -> Result<Json<Vec<Electrician>>, AppError> {
    let mut query_builder: QueryBuilder<Postgres> = QueryBuilder::new(queries::SELECT_ALL_ELECTRICIANS);

    if let Some(search_term) = &q.q {
        query_builder.push(" AND (name ILIKE ");
        query_builder.push_bind(format!("%{}%", search_term));
        query_builder.push(" OR city ILIKE ");
        query_builder.push_bind(format!("%{}%", search_term));
        query_builder.push(")");
    }

    if let Some(city) = &q.city {
        query_builder.push(" AND city ILIKE ");
        query_builder.push_bind(format!("%{}%", city));
    }

    if let Some(state_val) = &q.state {
        query_builder.push(" AND state = ");
        query_builder.push_bind(state_val);
    }

    if let Some(service) = &q.service {
        query_builder.push(" AND ");
        query_builder.push_bind(service);
        query_builder.push(" = ANY(services)");
    }

    if q.emergency.unwrap_or(false) {
        query_builder.push(" AND emergency = TRUE");
    }

    if let (Some(lat), Some(lon)) = (q.lat, q.lon) {
        let radius = q.radius_km.unwrap_or(50.0) * 1000.0;
        query_builder.push(" AND earth_distance(ll_to_earth(lat, lon), ll_to_earth(");
        query_builder.push_bind(lat);
        query_builder.push(", ");
        query_builder.push_bind(lon);
        query_builder.push(")) <= ");
        query_builder.push_bind(radius);
        query_builder.push(" ORDER BY earth_distance(ll_to_earth(lat, lon), ll_to_earth(");
        query_builder.push_bind(lat);
        query_builder.push(", ");
        query_builder.push_bind(lon);
        query_builder.push(")) ASC");
    } else {
        query_builder.push(" ORDER BY rating DESC, review_count DESC");
    }

    let limit = q.per_page.unwrap_or(50).min(100);
    let offset = (q.page.unwrap_or(1) - 1).max(0) * limit;

    query_builder.push(" LIMIT ");
    query_builder.push_bind(limit);
    query_builder.push(" OFFSET ");
    query_builder.push_bind(offset);

    let query = query_builder.build_query_as::<Electrician>();
    let results = query.fetch_all(&state.db).await?;
    
    Ok(Json(results))
}

pub async fn get_electrician(
    State(state): State<Arc<AppState>>,
    Path(id): Path<i32>,
) -> Result<Json<Electrician>, AppError> {
    let result = sqlx::query_as::<_, Electrician>(queries::GET_ELECTRICIAN_BY_ID)
    .bind(id)
    .fetch_optional(&state.db)
    .await?;

    match result {
        Some(electrician) => Ok(Json(electrician)),
        None => Err(AppError::NotFound),
    }
}

pub async fn create_electrician(
    State(state): State<Arc<AppState>>,
    Json(payload): Json<CreateElectrician>,
) -> Result<Json<Electrician>, AppError> {
    payload.validate()?;

    let result = sqlx::query_as::<_, Electrician>(queries::INSERT_ELECTRICIAN)
    .bind(&payload.name)
    .bind(&payload.license_number)
    .bind(&payload.phone)
    .bind(&payload.email)
    .bind(&payload.city)
    .bind(&payload.state)
    .bind(&payload.zip)
    .bind(&payload.services)
    .bind(payload.emergency)
    .bind(&payload.website)
    .bind(payload.lat)
    .bind(payload.lon)
    .fetch_one(&state.db)
    .await?;

    Ok(Json(result))
}
