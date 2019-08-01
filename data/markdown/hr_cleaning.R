library(janitor)

hr <- read_csv("C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/human_resources_dataset.csv") %>% 
  clean_names()


hr_cleaned <- hr %>% 
  mutate(
    education = case_when(
      education == 1 ~ "Below College",
      education == 2 ~ "College",
      education == 3 ~ "Bachelor",
      education == 4 ~ "Master",
      education == 5 ~ "Doctor"
    ),
    # job_satisfaction = case_when(
    #   job_satisfaction == 1 ~ "Low",
    #   job_satisfaction == 2 ~ "Medium",
    #   job_satisfaction == 3 ~ "High",
    #   job_satisfaction == 4 ~ "Very High"
    # ),
    performance_rating = case_when(
      performance_rating == 1 ~ "Low",
      performance_rating == 2 ~ "Good",
      performance_rating == 3 ~ "Excellent",
      performance_rating == 4 ~ "Outstanding"
    ),
    work_life_balance = case_when(
      work_life_balance == 1 ~ "Bad",
      work_life_balance == 2 ~ "Good",
      work_life_balance == 3 ~ "Better",
      work_life_balance == 4 ~ "Best"
    )
  ) %>% 
  select(age, department,
         distance_from_home, education,
         employee_count, gender, job_role,
         job_satisfaction, marital_status,
         monthly_income, num_companies_worked,
         performance_rating, total_working_years,
         work_life_balance, years_at_company,
         years_since_last_promotion) %>% 
  rownames_to_column(var = "id")


write_csv(hr_cleaned, "C:/Users/ChristianEZW/repositories/statistik_2_online_kurs/data/markdown/hr_cleaned.csv")
