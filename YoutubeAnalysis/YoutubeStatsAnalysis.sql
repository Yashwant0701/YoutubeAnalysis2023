# Youtube top players

# 1) Top continent in youtube : uploads, views , earnings, subsribers

select 
Country,
case
     when Country in ("Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'

     when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
         "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
        "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
         "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents,

sum(subscribers) as total_subs,
sum(uploads) as total_uploads,
round(sum(highest_yearly_earnings),0) as total_earnings,
sum(`video views`) as total_views,
count(Youtuber) as num_of_youtubers

 from youtube_stats.`global youtube statistics`
 group by(continents)
 order by 4 desc
 

 # 2) Percentage of pay per continent
 
 With pct_pay as (
 select 
 Country,
 case 
     when Country in ("Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'

     when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
         "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
        "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
         "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents,


round(sum(highest_yearly_earnings),0) as total_earnings

 from youtube_stats.`global youtube statistics`
 group by 1
 order by 2 desc
 )
 
 select 
 
 sum(total_earnings) as total_earnings,
round( 1.0 * sum(case when continents="Africa" then total_earnings else 0 end) / nullif(sum(total_earnings),0) * 100 , 2) as per_earning_africa,
round(1.0 * sum( case when continents = "Asia" then total_earnings else 0 end)/ nullif(sum(total_earnings),0) * 100 ,2) as per_earning_asia,
round(1.0 * sum(case when continents = 'North_America' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_North_America,
round(1.0 * sum(case when continents = 'Europe' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_Europe,
round(1.0 * sum(case when continents = 'South_America' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_South_America,
round(1.0 * sum(case when continents = 'Australia_and_Oceania' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_Australia_and_Oceania
 from pct_pay
 
 
 # 3) Top 8 Countries percentage pay
 
 With country_pct as (
 select 
 
 Country,
 sum(highest_yearly_earnings) as total_earnings
 
 from youtube_stats. `global youtube statistics`
 group by 1
 order by 2 desc
 )
 
 select 
 
 sum(total_earnings) as total_earnings,
round( sum(case when Country="United States" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_US,
round( sum(case when Country="India" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_India,
round( sum(case when Country="Brazil" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_Brazil,
round( sum(case when Country="South Korea" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_sKorea,
round( sum(case when Country="United Kindom" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_UK,
round( sum(case when Country="Pakistan" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_Pak,
round( sum(case when Country="Argentina" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_Argentina,
round( sum(case when Country="Russia" then total_earnings else 0 end) / nullif(sum(total_earnings),0) *100 ,2)  as per_Russia
 from country_pct
 
 
 # 4) Top 8 channel types : sum of views
 
 select 
 
 channel_type,
 sum(`video views`) as total_views
 
from youtube_stats. `global youtube statistics` 
group by 1
order by 2 desc
limit 8
