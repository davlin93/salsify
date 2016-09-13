##Setup
```
make
./build.sh
./run.sh
```

To generate random datafile which has lines with random ints (1..100000):
```
ruby file_creator.rb <FILENAME> <# OF LINES>
```

### How does your system work?
preprocess.rb breaks the main file down into chunks that are manageable to search through
server.rb then takes in the given line index, determines which chunk the line is located in, and returns it

### How will your system perform with a 1 GB file? a 10 GB file? a 100 GB file?
as the file size increases, the preprocess time will get longer and longer, but the server itself should stay quick since it is only finding then reading a 10k line file for each request.

### How will your system perform with 100 users? 10000 users? 1000000 users?
the server is currently singlethreaded (using thin), so the server will only start to slow down once requests have to queue.

### What documentation, websites, papers, etc did you consult in doing this assignment?
* http://www.ruby-doc.org/
* http://www.sinatrarb.com/
* various stackoverflow threads

### What third-party libraries or other tools does the system use? How did you choose each library or framework you used?
I'm using Sinatra & Thin for the server. Rails seemed like overkill for something so simple and I had never used sinatra before, so I wanted to try it. Thin seemed like the best choice for this project on a simple scale as well as being a step up from webrick.

### How long did you spend on this exercise? If you had unlimited more time to spend on this, how would you spend it and how would you prioritize each item?
~3 hours. The first thing I would do is setup a multithreaded server like unicorn or passenger so we could handle multiple requests at once. Another improvement would be to variably split the file chunks based on how large the original file was. For a huge file, a 10,000 line chunk size would lead to a large amount of chunk files. For a smaller file, say 25000 lines, it's probably OK to just read the source file directly without splitting it.

Line count also isn't the best metric for chunking the data, chunking it by filesize instead would avoid any files with 10,000 enourmously long lines.

### If you were to critique your code, what would you have to say about it?
I think it's pretty coherent and minimal, so I don't have too much to say about it besides the improvements I listed above. I could be convinced that I need to break some parts down into more methods.