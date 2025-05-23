CREATE	TABLE	productos	(
				id_producto	INT	PRIMARY	KEY,
				nombre	VARCHAR(50)	NOT	NULL,
				precio	DECIMAL(10,	2)	CHECK	(precio	>	0),
				cantidad_en_stock	INT
);