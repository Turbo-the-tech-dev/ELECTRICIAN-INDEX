pub const SELECT_ALL_ELECTRICIANS: &str = 
    "SELECT id, name, license_number, phone, email, city, state, zip,
            services, rating, review_count, emergency, website,
            lat, lon, last_verified
     FROM electricians WHERE TRUE";

pub const GET_ELECTRICIAN_BY_ID: &str = 
    "SELECT id, name, license_number, phone, email, city, state, zip,
            services, rating, review_count, emergency, website,
            lat, lon, last_verified
     FROM electricians WHERE id = $1";

pub const INSERT_ELECTRICIAN: &str = 
    "INSERT INTO electricians (
        name, license_number, phone, email, city, state, zip,
        services, emergency, website, lat, lon, last_verified
     ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, NOW())
     RETURNING *";
