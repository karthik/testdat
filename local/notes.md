Hi Karthik, Hi Dan,

Yes, I do have some messy tabular datasets. We have a test folder in messytables[1] full of files with weird headers, missing values, unicode encodings with and without BOM, footers in CSV, different separators and quoting styles, various null values, and different date formats. The folder is called "horror"[2]. One of my favorites is this file: https://github.com/okfn/messytables/blob/master/horror/weird_head_padding.csv. 

One of the SDSS logs that Dan mentioned is at [3]. This files is complicated because some cells contain newline characters. 

If you are looking for a larger number of test files, have a look at the CSV files in the european open data portal[4].

Dominik
------

https://gist.github.com/dhalperi/6223878

Definitely has UTF-8 troublemaking characters in it.

Dan

---

A few to throw in, hopefully fairly easy cases:

This spreadsheet broke both SQLShare and Google Fusion tables due to embedded quotes: 20121106_AllCounties_20121107_0930.csv

Here's another one I had some issues with in some past: http://www.electionresources.org/es/eus/data/2012.csv

I'll connect you with Dominik in a separate mail.

Thanks,
Dan