-- SQL Murder Mystery
/*
A crime has taken place and the detective needs your help.
You vaguely remember that crime was a muder that occured sometimes on Jan.15, 2018 and that it took place
in SQL City. 
Start by retrieving the corresponding crime scene report from the police department's database
*/
-----------------------------------------------------------------------------------------------------------------------------
-- Understanding the reports

-- find the report for the crime scene
Select *
From crime_scene_report
Where date = 20180115 and City = 'SQL City' and type = 'murder'

/*
Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr".
The second witness, named Annabel, lives somewhere on "Franklin Ave"

First witness: lives at the last house on Northwestern Dr
Second withness: Annable lives on Franklin Ave
*/
--------------------------------------------------------------------------------------------------------------------------
-- understand what data is in person 
Select * 
From person

-- Find Annable who lives in Franklin Ave
SELECT *
FROM person
Where name like '%Annabel%' and address_street_name ='Franklin Ave'

/*
id = 16371, name = Annable Miller, license_id = 490173, address_num 103, address_street_name = Franklin Ave, ssn = 318771143
*/

-- Find first witness
SELECT *
FROM person
Where address_street_name = 'Northwestern Dr'
Order by address_number DESC
/*
id = 14887, name = Morty Schapiro, license_id = 118009, address_number = 4919, address_street_name = Northwestern Dr, ssn = 111564949
*/

----------------------------------------------------------------------------
-- What is in drivers license?
Select * 
From drivers_license
Where id = 490173 OR id = 118009
/*
id	   age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
118009	64	84	     blue	     white   	male	 00NU00  	Mercedes-Benz	E-Class
490173	35	65	    green	     brown  	female	 23AM98	    Toyota	        Yaris

*/

--------------------------------------------------------------------------------------------------------------
-- facebook event
Select * 
From facebook_event_checkin

-- oh there is some common stuff here
Select * 
From facebook_event_checkin
Where date = 20180115 and person_id = 16371  -- Annabel facebook_event_checkin of murder date
/*
person_id	event_id	event_name           	date
16371	    4719	  The Funky Grooves Tour	20180115

*/

Select * 
From facebook_event_checkin
Where date = 20180115 and person_id = 14887
/*
witness 1
person_id	event_id	event_name	            date
14887	    4719	  The Funky Grooves Tour	20180115


*/

-------------------------------------------------------------------------
-- What did witness say in interview??

Select * 
From interview
Where person_id = 16371 or person_id = 14887

/*
person_id	transcript
14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

According to witness, murderer is someone has gym membership on "Get Fit Now Gym"

*/
---------------------------------------------------------------------------------------------------------
-- Lets check the person who check_in in Get fit Now Gym in 2018/01/09, has gold membership_status and id starts with 48Z

Select * 
From get_fit_now_member A
Left Join get_fit_now_check_in B
on A.id = B.membership_id
Where B.check_in_date = 20180109 and A.membership_status = 'gold' and id Like '%48Z%'

/*
id	 person_id	name	   membership_start_date	membership_status	membership_id	check_in_date	check_in_time	check_out_time
48Z7A	28819	Joe Germuska	20160305	            gold				48Z7A			20180109		1600			1730
48Z55	67318	Jeremy Bowers	20160101				gold				48Z55			20180109		1530			1700


Two suspect
1. Joe Germuska
2. Jeremy Bowers

*/
------------------------------------------------------------------------------------------------------------
-- find killer information
Select *
From person p
Left Join income i
on p.ssn = i.ssn
Where p.name = 'Joe Germuska' or p.name = 'Jeremy Bowers'

/*
id			name		license_id	address_number	address_street_name		ssn			ssn		annual_income
28819	Joe Germuska	173289			111			Fisk Rd					138909730	null		null
67318	Jeremy Bowers	423327			530			Washington Pl, Apt 3A	871539279	871539279	10500
*/

Select *
From facebook_event_checkin
Where person_id = 67318


Select *
From interview
Where person_id = 67318
/*
oh wait there is a twist
person_id	transcript
67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
		She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times 
		in December 2017.

67318(Jeremy Bowers) is a muderder but he was hired by someone else, some female around 5'5(65) or 5'7(67),
has red hair, drives Telsa Model S and had attended SQL Synphony Concert 3 times in December 2017
*/
--------------------------------------------------------------------------------------------------------------------------------------
-- let's us identify the identity first

Select *
From drivers_license
Where hair_color = 'red' AND
		height between 63 AND 69 AND
		gender = 'female' AND
			car_make = 'Tesla' AND
			car_model = 'Model S'

/*
id		age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
202298	68	66		green		red			female	500123			Tesla		Model S
291182	65	66		blue		red			female	08CM64			Tesla		Model S
918773	48	65		black		red			female	917UU3			Tesla		Model S

*/

Select *
From person
Where license_id = 202298 OR 
		license_id = 291182 OR
		license_id = 918773

/*
id		name				license_id	address_number	address_street_name		ssn
78881	Red Korb			918773			107				Camerata Dr		961388910
90700	Regina George		291182			332				Maple Ave		337169072
99716	Miranda Priestly	202298			1883			Golden Ave		987756388

We have final 3 suspect!

*/
--------------------------------------------------------------------------------------------------------------
-- find the people who were at the event more than 3 times
Select count(Distinct date) as times, person_id 
From facebook_event_checkin
Where event_name = 'SQL Symphony Concert' 
Group by person_id
Having times > 2

-- find who have attended event more than 2 times
with new As(
SELECT COUNT(DISTINCT date) as times, person_id
FROM facebook_event_checkin
WHERE event_name = "SQL Symphony Concert"
GROUP BY person_id
Having times >2
)
Select * From new
Where person_id = 78881 OR
		person_id = 90700 OR
		person_id = 99716

/*
times	person_id
3		99716
*/
----------------------------------------------------
-- we found murderer
Select *
From person
Where id = 99716

/*
id		name				license_id	address_number	address_street_name		ssn
99716	Miranda Priestly	202298			1883			Golden Ave		987756388

*/
-- Therefore Miranda Priestly is a brain behind Murder