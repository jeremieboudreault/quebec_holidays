# comapre.R


# Compare the results with the results from the Python package.


# Project : quebec_holidays
# Author  : Jeremie Boudreault
# Email   : Prenom.Nom@inrs.ca
# Depends : R (v4.4.2)
# License : CC BY-NC-ND 4.0


# Packages ---------------------------------------------------------------------


library(data.table)


# Imports ----------------------------------------------------------------------


# Manually created file.
x <- fread("out/quebec_holidays_v20250421.csv")

# Automatic file from Python script.
x_can <- fread("data/canada_public_holidays_1990_2024.csv")


# Compare ----------------------------------------------------------------------


# Merge both file to compare.
tbl <- merge(
    x   = x[HOLIDAY_CHR != "" & YEAR >= 1990, .(DATE, HOLIDAY_QC = HOLIDAY_CHR)],
    y   = x_can[Province == "QC", .(DATE = Date, HOLIDAY_CAN = Holiday)],
    by  = "DATE",
    all.x = TRUE,
    all.y = TRUE
)[order(DATE), ]

# Check the number of discrepensies.
View(tbl[is.na(HOLIDAY_QC) | is.na(HOLIDAY_CAN), ])

# Overall, the agreement is good with some small discrepensies, because the
# Quebec file already consider the week-end and the actual date people
# will take off.
