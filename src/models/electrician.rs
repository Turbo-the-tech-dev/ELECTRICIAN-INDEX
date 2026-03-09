use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use validator::Validate;
use chrono::NaiveDateTime;

#[derive(Debug, Serialize, FromRow, Clone)]
pub struct Electrician {
    pub id: i32,
    pub name: String,
    pub license_number: Option<String>,
    pub phone: String,
    pub email: Option<String>,
    pub city: String,
    pub state: String,
    pub zip: String,
    pub services: Vec<String>,
    pub rating: f32,
    pub review_count: i32,
    pub emergency: bool,
    pub website: Option<String>,
    pub lat: Option<f64>,
    pub lon: Option<f64>,
    pub last_verified: NaiveDateTime,
}

#[derive(Deserialize, Validate)]
pub struct SearchQuery {
    pub q: Option<String>,
    pub city: Option<String>,
    pub state: Option<String>,
    pub service: Option<String>,
    pub emergency: Option<bool>,
    pub lat: Option<f64>,
    pub lon: Option<f64>,
    pub radius_km: Option<f64>,
    pub page: Option<i64>,
    pub per_page: Option<i64>,
}

#[derive(Deserialize, Validate)]
pub struct CreateElectrician {
    #[validate(length(min = 3, max = 120))]
    pub name: String,
    pub license_number: Option<String>,
    #[validate(length(min = 10, max = 15))]
    pub phone: String,
    #[validate(email)]
    pub email: Option<String>,
    #[validate(length(min = 2))]
    pub city: String,
    #[validate(length(equal = 2))]
    pub state: String,
    #[validate(length(min = 5, max = 10))]
    pub zip: String,
    pub services: Vec<String>,
    pub emergency: bool,
    pub website: Option<String>,
    pub lat: Option<f64>,
    pub lon: Option<f64>,
}
