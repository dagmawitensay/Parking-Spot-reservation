CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE parking_compound (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL, 
    location VARCHAR(200) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    available_spots INT NOT NULL,
    total_spots INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id)
);
CREATE TABLE parking_spots (
    id INT AUTO_INCREMENT PRIMARY KEY,
    compund_id INT NOT NULL,
    FOREIGN KEY (compund_id) REFERENCES parking_compound(id)
);

CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    parking_spot_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parking_spot_id) REFERENCES parking_spots(id)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    parking_compound_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parking_compound_id) REFERENCES parking_compound(id)
);

DROP TABLE users;

-- CreateTable
CREATE TABLE compound_owner (
    id INTEGER NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(150) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone_no VARCHAR(150) NOT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE spot_user (
    id INTEGER NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(150) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone_no VARCHAR(150) NOT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE user (
    id INTEGER NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(200) NOT NULL,
    hash VARCHAR(200) NOT NULL,
    refresh_token VARCHAR(200) NULL,
    role ENUM('owner', 'reserver') NOT NULL DEFAULT 'reserver',
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;