# ImageBackup

## Keep your photos and videos organized by date.

### A simple terminal app to crawl a folder (usually a camera card's DCIM folder) for pictures and videos, and pop them in dated folders to your destination folder of choice. Uses exif data when available, creation_time, or the file's own creation date if nothing better is present.  
### Will also copy over any xmp sidecar files found, not overwriting.

Source is available here: [https://github.com/adrian-sal-kennedy/imagebackup]()

## Options:
-n, --dry-run  
Run without actually doing anything. Good for making sure things are working properly. This will also give you console output which helps identify unreadable files.

-a, --add-filetype *extension* *type*  
This will add a custom file type to the list of files it's looking for. If you have an arcane digital camera (we currently support canon, sony, pentax but new stuff comes out all the time), this will allow you to add your raw files.  
You can also access *filetypes.csv* and add them manually, but ensure there's a blank line at the end or this program may behave badly.

-m will move (deleting the original), which is probably not a good idea in most cases but still useful at times.

## Usage:

### To backup a camera card:

```bash
$ cd /media/username/EOS_DIGITAL/DCIM
$ imagebackup.rb ~/Photos/raw
```

This will search all files within the DCIM folder, check them with either exiv2 (for stills) or ffprobe (for videos) and retrieve their creation dates.  
It will then copy them to a folder of the form ```~/Photos/raw/<yyyy>-<mm>-<dd>```  
If it's unable to find metadata in a file it will look at the file's creation time attribute, which is less reliable but usually ok.

### To register a new file type:

```bash
$ imagebackup.rb --add-filetype orf pic
```
or
```bash
$ imagebackup.rb -a orf pic
```
This will work with ```*.ORF```, ```orf```, ```".orf"``` as it will strip off any unnecessary characters. It is case-insensitive.

### To do a dry run, checking each file and destination but not actually copying:

```bash
$ imagebackup.rb -n ~/Photos/raw
```
or
```bash
$ imagebackup.rb ~/Photos/raw --dry-run
```

### To move files instead of copying them (careful!):
```bash
$ imagebackup.rb -m ~/Photos/raw
```
or
```bash
$ imagebackup.rb --move ~/Photos/raw
```

### To make symbolic links instead of copying files:
```bash
$ imagebackup.rb -l ~/Photos/raw
```
or
```bash
$ imagebackup.rb --link ~/Photos/raw
```
This mode can be useful if you want to operate on the files in one place but keep them on their media. Particularly useful for large movie files.

## Demo video:

[![screenshot of a terminal in ubuntu](https://i.vimeocdn.com/video/872585720_640.jpg)](https://vimeo.com/403201846)


## Dependencies:

**Ruby** v2.3.0 or greater, plus gems:
  - [exiv2](https://rubygems.org/gems/exiv2/versions/0.0.8) to retrieve EXIF date/time.
  - [ffprober](https://github.com/beanieboi/ffprober) to retrieve video container date/time tags if present.
  - [colorize](https://github.com/fazibear/colorize) to make output a little more readable and engaging.

Ruby modules:
  - [fileutils](https://ruby-doc.org/stdlib-2.4.1/libdoc/fileutils/rdoc/FileUtils.html) to manage file operations (get attributes, copy, move, link).
  - [csv](https://ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html) to process the list of available file types.

Bundler should handle all these dependencies. If for some reason it doesn't you can run this in terminal:  
```bash
$ gem install exiv2 ffprober colorize
```
