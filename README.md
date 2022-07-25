# ycombinator_githubs
A web scraping / data mining script for extracting beginner-friendly github repos from Y Combinator's company database: https://www.ycombinator.com/companies/

This scraper is designed with [Microverse](https://www.microverse.org/) students and graduates in mind. It extracts the most recent and active Y Combinator github repos, written in JavaScript and Ruby, which are the two languages Micronauts use the most!

The resulting list as of July 2022 for S21, W21, S22 and W22, are in [`04_sorted_repos.csv`](./04_sorted_repos.csv). Be sure to check it out to find beginner-friendly repos written in JS and Ruby.

## Installation

1. Clone the repository.
2. `$ cd ycombinator_githubs`
3. `$ npm install`

## Usage

1. Generate your github Personal Access Token as detailed in [`.env.sample`](./.env.sample)
2. Change the name of `.env.sample` to simply `.env`
3. `$ ./scrape.sh`

For details on how the scraping works, or what the `.csv` files contain, read [`scrape.sh`](./scrape.sh)
