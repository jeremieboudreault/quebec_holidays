# main.R


# Compute the Holidays for the province of Quebec.


# Project : quebec_holidays
# Author  : Jeremie Boudreault
# Email   : Prenom.Nom@inrs.ca
# Depends : R (v4.4.2)
# License : CC BY-NC-ND 4.0


# Packages ---------------------------------------------------------------------


library(data.table)


# Functions --------------------------------------------------------------------


source("R/guess_easter.R")


# Globals ----------------------------------------------------------------------


weekday_list <- list(
    Mon = 1L,
    Tue = 2L,
    Wed = 3L,
    Thu = 4L,
    Fri = 5L,
    Sat = 6L,
    Sun = 7L
)


# Basic information for the holiday table --------------------------------------


# Initial a data.table with <DATE> from 1980 to 2024.
hol_tbl <- data.table::data.table(
    DATE = seq.Date(as.Date("1980-01-01"), as.Date("2024-12-31"), by = 1L)
)

# Extract <YEAR>, <MONTH>.
hol_tbl[, YEAR := as.integer(format(DATE, "%Y"))]
hol_tbl[, MONTH := as.integer(format(DATE, "%m"))]
hol_tbl[, DAY := as.integer(format(DATE, "%d"))]

# Create <WEEKDAY_CHR> for Mon, Tue, Wed, ..., Sun.
hol_tbl[, WEEKDAY_CHR := weekdays(DATE, abbreviate = TRUE)]

# Convert to <WEEKDAY>, integer from 1 (Mon) to 7 (Sun).
hol_tbl[, WEEKDAY := as.integer(weekday_list[data.table::chmatch(
    x     = WEEKDAY_CHR,
    table = names(weekday_list)
)])]

# Extract <WEEKEND> from <WEEKDAY>.
hol_tbl[, WEEKEND := 0]
hol_tbl[WEEKDAY %in% c(6L, 7L), WEEKEND := 1]


# Holidays in Quebec -----------------------------------------------------------


# Set the <HOLIDAY_CHR>.
hol_tbl[, HOLIDAY_CHR := as.character(NA)]

# New year (01/01, except for week-end).
hol_tbl[MONTH == 1L  & DAY == 1L  & WEEKDAY %in% 1:5, HOLIDAY_CHR := "New Year"]  # When it is not on week-end
hol_tbl[MONTH == 12L & DAY == 31L & WEEKDAY == 5L,    HOLIDAY_CHR := "New Year"]  # When it is on Saturday, use Friday
hol_tbl[MONTH == 1L  & DAY == 2L  & WEEKDAY == 1L,    HOLIDAY_CHR := "New Year"]  # When it is on Sunday, use Monday

# Good Friday and Easter monday (depend on the moon).
hol_tbl[, EASTER_DATE := as.Date(guess_easter(YEAR), format = "%Y-%m-%d")]
hol_tbl[DATE == EASTER_DATE - 2L, HOLIDAY_CHR := "Good Friday"]
hol_tbl[DATE == EASTER_DATE + 1L, HOLIDAY_CHR := "Easter Monday"]
hol_tbl[, EASTER_DATE := NULL]

# Patriot day (first Monday < 05/25).
hol_tbl[DAY %in% seq.int(18L, 24L) & MONTH == 5L & WEEKDAY == 1L, HOLIDAY_CHR := "Patriot"]

# Saint-Jean Baptiste (24/06, except for week-end).
hol_tbl[MONTH == 6L & DAY == 24L & WEEKDAY %in% 1:5, HOLIDAY_CHR := "Saint-Jean-Baptiste"]  # When it is not on week-end
hol_tbl[MONTH == 6L & DAY == 25L & WEEKDAY == 1L,    HOLIDAY_CHR := "Saint-Jean-Baptiste"]  # When it is on Sunday, use Monday
hol_tbl[MONTH == 6L & DAY == 23L & WEEKDAY == 5L,    HOLIDAY_CHR := "Saint-Jean-Baptiste"]  # When it is on Saturday, use Friday

# Canada day (01/07, except for week-end).
hol_tbl[MONTH == 7L & DAY == 1L  & WEEKDAY %in% 1:5, HOLIDAY_CHR := "Canada day"]  # When it is not on week-end
hol_tbl[MONTH == 7L & DAY == 2L  & WEEKDAY == 1L,    HOLIDAY_CHR := "Canada day"]  # When it is on Saturday, use Friday
hol_tbl[MONTH == 6L & DAY == 30L & WEEKDAY == 5L,    HOLIDAY_CHR := "Canada day"]  # When it is on Sunday, use Monday

# Labor day (first Monday of September).
hol_tbl[MONTH == 9L & DAY %in% 1:7 & WEEKDAY == 1L, HOLIDAY_CHR := "Labor day"]

# Thanksgiving (second Monday of October)
hol_tbl[MONTH == 10L & DAY %in% 8:14 & WEEKDAY == 1L, HOLIDAY_CHR := "Thanksgiving"]

# Christmas (25/12 except for week-end and overlap with Boxing Day)
hol_tbl[DAY == 25L & MONTH == 12L & WEEKDAY %in% 1:4, HOLIDAY_CHR := "Christmas"]  # When it is from Mon to Thu
hol_tbl[DAY == 24L & MONTH == 12L & WEEKDAY %in% 4:5, HOLIDAY_CHR := "Christmas"]  # When if is on Fri or Sat, it is moved 1 day before
hol_tbl[DAY == 26L & MONTH == 12L & WEEKDAY %in% 1L,  HOLIDAY_CHR := "Christmas"]  # When if is on Sun, it is moved to Mon

# Boxing day (26/12 except for week-end and overlap with Christmas).
hol_tbl[DAY == 26L & MONTH == 12L & WEEKDAY %in% 2:5, HOLIDAY_CHR := "Boxing day"]  # When it is from Tue to Fri
hol_tbl[DAY == 25L & MONTH == 12L & WEEKDAY %in% 5L,  HOLIDAY_CHR := "Boxing day"]  # When if is on Sat, it is moved to Fri
hol_tbl[DAY == 27L & MONTH == 12L & WEEKDAY %in% 1:2, HOLIDAY_CHR := "Boxing day"]  # When if is on Sun or Mon, it is moved 1 day after

# Check results.
table(hol_tbl[, .(HOLIDAY_CHR)])
table(hol_tbl[, .(HOLIDAY_CHR, WEEKDAY)])

# Create a <HOLIDAY>
hol_tbl[, HOLIDAY := 0L]
hol_tbl[!is.na(HOLIDAY_CHR), HOLIDAY := 1L]

# Create a <HOLIDAY_WE> indicator.
hol_tbl[, HOLIDAY_WE := 0L]
hol_tbl[HOLIDAY == 1L | WEEKEND == 1L, HOLIDAY_WE := 1L]

# Check results.
mean(hol_tbl$HOLIDAY) * 365.25 # 10 holidays in Quebec
mean(hol_tbl$WEEKEND) * 365.25 # 104 week-ends days ~ 2/7
mean(hol_tbl$HOLIDAY_WE) * 365 # 114 days.

# Replace NA by empty values.
hol_tbl[is.na(HOLIDAY_CHR), HOLIDAY_CHR := ""]


# Reorganize the columns -------------------------------------------------------


hol_tbl <- hol_tbl[, .(
    DATE, YEAR, MONTH, DAY, WEEKDAY, WEEKDAY_CHR, WEEKEND, HOLIDAY, HOLIDAY_CHR, HOLIDAY_WE
)]


# Export table -----------------------------------------------------------------


data.table::fwrite(
    x    = hol_tbl,
    file = "out/quebec_holidays_v20250421.csv",
    sep  = ";"
)
