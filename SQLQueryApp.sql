Problem- Need to help software developer in decision making about which app to built.


--Checking if there is any missing data
select count(distinct id) from AppleStore
select count(distinct id) from AppleStore_description

select * from AppleStore
select * from appleStore_description

--Checking for any missing data
select count(*) from AppleStore 
where track_name is null or user_rating is null or prime_genre is null

select * from appleStore_description 
where app_desc is null



-- Check the number of apps in each genre
select prime_genre, count(*) as Numapps from AppleStore
group by prime_genre
order by Numapps desc



--Overall Rating's Overview
Select min(user_rating) as Min_rating,
	   max(user_rating) as Max_rating,
	   avg(user_rating) as Avg_rating
from AppleStore




--Genre wise Rating's Overview
Select min(user_rating) as Min_rating,
	   max(user_rating) as Max_rating,
	   avg(user_rating) as Avg_rating, prime_genre
from AppleStore 
group by prime_genre
order by avg(user_rating) desc





-- **Data Analysis**
select * from AppleStore

--Determine whether paid apps has higher rating than free apps
select temp1,avg(user_rating) from (
select (user_rating), case when price > 0 then 'Paid'
			when price = 0 then 'Free' end as temp1
from AppleStore ) sub
group by temp1




--Check if apps with higher supporting languages have higher ratings

select language, avg(user_rating) from (
select (user_rating), case when lang_num < 10 then '<10 lang'
						   when lang_num between 10 and 30 then '10-30 lang'
						   else '>30 lang' end as language
from AppleStore) sub
group by language




--Check genre with lower ratings
select top 5 prime_genre, avg(user_rating) as Avg_rating 
from AppleStore 
group by prime_genre 
order by Avg_rating 




--Check correlation between the description and rating
select * from appleStore_description

select a.user_rating, b.id, b.app_desc from AppleStore a join appleStore_description b on a.id = b.id

select desc_len , avg(user_rating) as avg_rating from (
select user_rating, app_desc,  case when len(app_desc) < 500 then 'short'
							when len(app_desc) between 500 and 1000 then 'medium'
							when len(app_desc) > 500 then 'long' end as desc_len
from (select a.user_rating, b.app_desc from AppleStore a join appleStore_description b on a.id = b.id) sub1) sub2
group by desc_len 
order by avg_rating desc




--Check top rated apps for each genre
select * from AppleStore

select prime_genre, track_name, user_rating from(
select prime_genre, track_name, user_rating, 
rank() over(partition by prime_genre order by user_rating desc, rating_count_tot desc) as ranking
from AppleStore) sub
where ranking =1
--rating_count_tot desc => It breaks all the ties





Results and Key findings:
1. Games & Entertainment have most number of apps so high competition.
2. Paid apps have better ratings as compared to free apps
3. Productivity & Music has highest avg ratings
4. Apps supporting languages between 10 and 30 have higher ratings
5. Catalogs & Finance genre has least ratings
6. Apps with long description have higer rating than others
7. New apps must aim for avg ratings higher than 3.5

