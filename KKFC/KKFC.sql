INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_kfc', 'KFC', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_kfc', 'KFC', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_kfc', 'KFC', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('kfc', 'KFC', 1);

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('88','kfc', 0, 'novice', 'Recrue', 100, '', ''),
('89','kfc', 1, 'experimente', 'Experimenté', 100, '', ''),
('90','kfc', 2, 'boss', 'Gérant', 100, '', '');

INSERT INTO `items` (name, label, `limit`) VALUES

	('bdp', 'Poulet', 50),

	('couisse', 'Cuisse de poulet', 10),

	('tenders', 'Tenders de poulet', 10),

	('water', 'Evian', 10),

	('cocac', 'Coca Cherry', 10),
				
	('bx10', 'Bucket de poulet x10', 10),
				
	('wrap', 'Wrap', 10),
						
	('mozastick', 'Mozarella Stick', 10),
						
    ('fantaT', 'Fanta Tropical', 10),
								
    ('nx9', 'Nuggets x9', 10),
									
    ('Obacon', 'Original Bacon', 10):


;