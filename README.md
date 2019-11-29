# Scraping eBay

This project contains a set of scripts used to scrape Ebay's products data using [Scrapy Web Crawling Framework](https://scrapy.org/).
 
In the current stage, the list of products scraped is defined by a
search string (the same used in eBay web page). Additions in the
`parselots` branch help to parse information about lots of a product
for sorting by price per lot. The script `parselots` uses this eBay
scraping framework and adds some Perl to enable the parsing of lot data.

An example run of the output of `parselots` on the term "ssd lot" can
be found in [example/ssd_lot.csv](./example/ssd_lot.csv) and
[example/ssd_lot.lot.csv](./example/ssd_lot.lot.csv).

## Old examples
An example of the scraped data can be found in the ***data/*** folder.

The image below shows a scraped data for the *"iphone X 256gb"* search string in ebay.com

![ebay_iphone_x_256gb_products_sample](https://user-images.githubusercontent.com/22003608/45721730-a6e3fc80-bb7f-11e8-8e8f-50103bf7c842.jpg)
)

# How to use

You will need Python 3.x to run the scripts.
Python can be downloaded [here](https://www.python.org/downloads/).

You have to install ***scrapy*** framework:
* In command prompt/Terminal: *pip install scrapy*
* If you are using [Anaconda Python distribution](https://anaconda.org/anaconda/python): *conda install -c conda-forge scrapy*

Once you have installed *scrapy* framework, just clone/download this project, access the folder in command prompt/Terminal and run the following command:

*scrapy crawl ebay -o products.csv*

You can change the output format to JSON or XML by change the output file extension (ex: *products.json*).

## Using `venv`s

@hurricos reccomends the use of a Python virtual environment to keep
your python packages unpolluted. To set one up, you will need the
`venv` module (under Debian-based systems like Ubuntu, `sudo apt
install python3-venv`).

Then:

    cd scraping-ebay/
    python3 -m venv .
    source bin/activate             # Enters the virtual environment
    python3 -m pip install scrapy   # Installs under the virtuan environment
    
### Search string

The default search string is *nintendo switch console* and it can be changed in the command line with the *-a* flag.
For example, to search to *Xbox one X* you can use:

`scrapy crawl ebay -o products.csv -a search="Xbox one X"`

### Parsing searches for lots

Some quick Perl code was thrown together to parse .csv-based output for lot information.

For example:

    scrapy crawl ebay -a search="ssd lot" -o data/ssd_lots.csv
    perl ./perl/parseLotAmounts.pl ./data/ssd_lots.csv
     
#### Perl requirements

On Debian-based systems, you will need the package `libtext-csv-perl`
to work with CSVs under Perl.
