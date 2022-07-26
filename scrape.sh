# 1. Get the list of companies from the YCombinator API and scrape any github links from their websites.
#    This generates 01_companies_githubs.csv

node yc_scraper.js | tee > 01_companies_githubs.csv

# 2. Extract the github usernames (org names) from the previous list.
#    This generates 02_orgs.csv

cat 01_companies_githubs.csv | \
    grep "|" | \
    grep -o "github.com/[-A-Za-z0-9_.][-A-Za-z0-9_.]*" | \
    sort | \
    uniq > 02_orgs.csv

# 3. Get the list of gihub API URLs from the orgs in the previous list
#    This will generate 03_repos.csv

cat 02_orgs.csv | \
    grep -v "^#" | \
    sed 's/github.com//' | \
    sed 's/.*/https:\/\/api.github.com\/orgs&\/repos/' > 03_repos.csv

# 4. Get number of issues, coding language and repo URL from the github API and sort by # of issues.
#    NOTE: This will use your github Personal Access Token so be sure to read env.sample first
#    This will generate 04_sorted_repos.csv

cat 03_repos.csv | \
    grep -v "^#" | \
    while read line ; do node github_scraper.js $line ; done | \
    sort -rn > 04_sorted_repos.csv

# 5. Filter out non-YCombinator repos from final list
#    This generates 05_final_repos.csv

cat 04_sorted_repos.csv | \
    grep -v \
    -e 'github/' \
    -e 'mozilla/' \
    -e 'mozdevs/' \
    -e 'twbs/' \
    -e 'axios/' \
    -e 'tailwindcss/' \
    -e 'sindersorhus/' \
    -e 'necolas/' \
    -e 'muicss/' \
    -e 'wix/' \
    -e 'suitcss/' \
    -e 'flatpicker/' > 05_final_repos.csv

# The most active github repositories written in JavaScript and Ruby will be located at the top of the 05 file.
# These are also the most recent repositories from Y Combinator companies.
# The idea is that these repos will be fresh and welcoming to beginners, with plenty of activity to participate.

cat 05_final_repos.csv | \
    ./jsonize.sh | \
    tac | \
    sed '2s/,//' | \
    tac > 06_repos.json