# ImageBackup

## Keep your photos and videos organized by date.

### A simple terminal app to crawl a folder (usually a camera card's DCIM folder) for pictures and videos, and pop them in dated folders to your destination folder of choice. Uses exif data when available, creation_time, or the file's own creation date if nothing better is present.


## Dependencies:

**Ruby** v2.3.0 or greater, plus gems:
  - exiv2
  - ffprober  

Ruby modules:
  - fileutils.rb
  - json  

Bundler should handle all these dependencies. If for some reason it doesn't you can run this in terminal:  
```bash
$ gem install exiv2 ffprober
```

## Usage:

```bash
$ cd /media/username/EOS_DIGITAL/DCIM
$ imagebackup ~/Photos/raw
```
This will search all files within the DCIM folder, check them with either exiv2 (for stills) or ffprobe (for videos) and retrieve their creation dates.  
It will then copy them to a folder of the form ```~/Photos/raw/<yyyy>-<mm>-<dd>```  
If it's unable to find metadata in a file it will look at the file's creation time attribute, which is less reliable but usually ok.


## Options:
-m will move (deleting the original), which is probably not a good idea in most cases but still useful at times.