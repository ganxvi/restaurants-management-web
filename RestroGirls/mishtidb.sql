
CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `short_desc` varchar(250) NOT NULL,
  `long_desc` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `food` (
  `id` int(11) NOT NULL,
  `cat_id` int(10) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_id` varchar(20) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `food_id` varchar(10) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `timestamp` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `timestamp` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `order_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(20) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `food_id` varchar(10) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `timestamp` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE ASSERTION unique_user_email
CHECK (
    NOT EXISTS (
        SELECT email
        FROM users
        GROUP BY email
        HAVING COUNT(*) > 1
    )
);


CREATE ASSERTION valid_user_id_in_orders
CHECK (
    NOT EXISTS (
        SELECT *
        FROM orders o
        LEFT JOIN users u ON o.user_id = u.id
        WHERE u.id IS NULL
    )
);

DELIMITER //
CREATE TRIGGER log_new_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_logs (order_id, user_id, food_id, user_name, timestamp)
    VALUES (NEW.order_id, NEW.user_id, NEW.food_id, NEW.user_name, NEW.timestamp);
END;
//
DELIMITER ;

INSERT INTO `admin` (`id`, `name`, `email`, `password`) VALUES
(1, 'Admin', 'admin@gmail.com', '12345');

INSERT INTO `categories` (`id`, `name`, `short_desc`, `long_desc`) VALUES
(7, 'North Indian', 'This is a popular category in Northern India', 'Indian cuisine encompasses a wide variety of regional cuisine native to India. Given the range of diversity in soil type, climate and occupations, these cuisines vary significantly from each other and use locally available chocolates, herbs, vegetables and fruits. The dishes are then served according to taste in either mild, medium or hot. Indian food is also heavily influenced by religious and cultural choices, like Hinduism and traditions.'),
(8, 'Chinese', 'Chinese cuisine is an important part of Chinese culture, which includes cuisine originating from the diverse regions of China.', 'A number of different styles contribute to Chinese cuisine but perhaps the best known and most influential are Cantonese cuisine, Shandong cuisine, Jiangsu cuisine (specifically Huaiyang cuisine) and Sichuan cuisine.'),
(9, 'South Indian', 'South Indian cuisine includes the cuisines of the five southern states of India Andhra Pradesh, Karnataka, Kerala, Tamil Nadu and Telangana.', 'The cuisines of Andhra Pradesh are the spiciest in all of India. Generous use of chili and tamarind make the dishes tangy and hot. The majority of dishes are vegetable or lentil-based.'),
(10, 'Snacks', ' A snack is a small portion of food eaten between meals.', 'A snack is a small portion of food eaten between meals. This may be a snack food, such as potato chips or baby carrots, but can also simply be a small amount of any food.'),
(11, 'Himalayan Food', 'Nepalese cuisine comprises a variety of cuisines based upon ethnicity, soil and climate relating to Nepal cultural diversity and geography.', 'Much of the cuisine is variation on Asian themes. Other foods have hybrid Tibetan, Indian and Thai origins. They were originally filled with buffalo meat but now also with goat or chicken, as well as vegetarian preparations. Special foods such as sel roti, finni roti and patre are eaten during festivals such as Tihar.');

INSERT INTO `food` (`id`, `cat_id`, `fname`, `description`) VALUES
(1, 9, 'Dosa', 'I love Dosa very much. Its a South Indian Food and Everybody loves it!'),
(7, 7, 'Egg Role', 'This is a North Indian Pop Food. Everybody likes it so damn very much.'),
(8, 8, 'Chowmin', 'This is a Chinese Pop Food. Everybody likes it so damn very much.'),
(9, 10, 'French Fries', 'This is a Snacks Food. Everybody likes it so damn very much with Tea or Coffee.'),
(10, 11, 'Momos', 'This is a Himalayan Pop Food. Everybody likes it so damn very much. Its comes with different flavors!'),
(11, 8, 'Hakka Noodles', 'This food is so much popular even in India. It tastes like Chowmein but with Gravy. ');

INSERT INTO `orders` (`id`, `order_id`, `user_id`, `food_id`, `user_name`, `timestamp`) VALUES
(3, 'RSTGF384345', '3', '1', 'Samprit', '04:09:2019 12:02:06am');

INSERT INTO `users` (`id`, `name`, `email`, `password`, `timestamp`) VALUES
(3, 'Mishti Chakraborty', 'mishti@gmail.com', '12345', '06:08:2019 01:40:08am');
