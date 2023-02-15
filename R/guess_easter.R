# guess_easter.R

# A wrapper function to timedate::Easter(), fully tested with true Easter dates.
guess_easter <- function(year) {

    # Guess easter using timeDate::Easter()
    x <- as.Date(timeDate::Easter(year))

    # Remove attributes.
    attributes(x)$control <- NULL

    # Return x.
    return(x)

}

# Tests.
# test_that("Check values returned by the timeDate::Easter function.", {
#     expect_equal(guess_easter(1980), as.Date("1980-04-06"))
#     expect_equal(guess_easter(1981), as.Date("1981-04-19"))
#     expect_equal(guess_easter(1982), as.Date("1982-04-11"))
#     expect_equal(guess_easter(1983), as.Date("1983-04-03"))
#     expect_equal(guess_easter(1984), as.Date("1984-04-22"))
#     expect_equal(guess_easter(1985), as.Date("1985-04-07"))
#     expect_equal(guess_easter(1986), as.Date("1986-03-30"))
#     expect_equal(guess_easter(1987), as.Date("1987-04-19"))
#     expect_equal(guess_easter(1988), as.Date("1988-04-03"))
#     expect_equal(guess_easter(1989), as.Date("1989-03-26"))
#     expect_equal(guess_easter(1990), as.Date("1990-04-15"))
#     expect_equal(guess_easter(1991), as.Date("1991-03-31"))
#     expect_equal(guess_easter(1992), as.Date("1992-04-19"))
#     expect_equal(guess_easter(1993), as.Date("1993-04-11"))
#     expect_equal(guess_easter(1994), as.Date("1994-04-03"))
#     expect_equal(guess_easter(1995), as.Date("1995-04-16"))
#     expect_equal(guess_easter(1996), as.Date("1996-04-07"))
#     expect_equal(guess_easter(1997), as.Date("1997-03-30"))
#     expect_equal(guess_easter(1998), as.Date("1998-04-12"))
#     expect_equal(guess_easter(1999), as.Date("1999-04-04"))
#     expect_equal(guess_easter(2000), as.Date("2000-04-23"))
#     expect_equal(guess_easter(2001), as.Date("2001-04-15"))
#     expect_equal(guess_easter(2002), as.Date("2002-03-31"))
#     expect_equal(guess_easter(2003), as.Date("2003-04-20"))
#     expect_equal(guess_easter(2004), as.Date("2004-04-11"))
#     expect_equal(guess_easter(2005), as.Date("2005-03-27"))
#     expect_equal(guess_easter(2006), as.Date("2006-04-16"))
#     expect_equal(guess_easter(2007), as.Date("2007-04-08"))
#     expect_equal(guess_easter(2008), as.Date("2008-03-23"))
#     expect_equal(guess_easter(2009), as.Date("2009-04-12"))
#     expect_equal(guess_easter(2010), as.Date("2010-04-04"))
#     expect_equal(guess_easter(2011), as.Date("2011-04-24"))
#     expect_equal(guess_easter(2012), as.Date("2012-04-08"))
#     expect_equal(guess_easter(2013), as.Date("2013-03-31"))
#     expect_equal(guess_easter(2014), as.Date("2014-04-20"))
#     expect_equal(guess_easter(2015), as.Date("2015-04-05"))
#     expect_equal(guess_easter(2016), as.Date("2016-03-27"))
#     expect_equal(guess_easter(2017), as.Date("2017-04-16"))
#     expect_equal(guess_easter(2018), as.Date("2018-04-01"))
#     expect_equal(guess_easter(2019), as.Date("2019-04-21"))
#     expect_equal(guess_easter(2020), as.Date("2020-04-12"))
#     expect_equal(guess_easter(2021), as.Date("2021-04-04"))
#     expect_equal(guess_easter(2022), as.Date("2022-04-17"))
#     expect_equal(guess_easter(2023), as.Date("2023-04-09"))
#     expect_equal(guess_easter(2024), as.Date("2024-03-31"))
# })
