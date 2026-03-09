use axum::{
    http::StatusCode,
    response::{IntoResponse, Response},
    Json,
};
use serde_json::json;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum AppError {
    #[error("Database error: {0}")]
    Database(#[from] sqlx::Error),
    #[error("Validation error: {0}")]
    Validation(#[from] validator::ValidationErrors),
    #[error("Not found")]
    NotFound,
    #[error("Internal server error")]
    Internal(String),
}

impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        let (status, error_message) = match self {
            AppError::Database(e) => (StatusCode::INTERNAL_SERVER_ERROR, e.to_string()),
            AppError::Validation(e) => (StatusCode::BAD_REQUEST, e.to_string()),
            AppError::NotFound => (StatusCode::NOT_FOUND, "Resource not found".to_string()),
            AppError::Internal(msg) => (StatusCode::INTERNAL_SERVER_ERROR, msg),
        };

        let body = Json(json!({
            "error": error_message,
        }));

        (status, body).into_response()
    }
}
