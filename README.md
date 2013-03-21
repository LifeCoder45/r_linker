# What is r_linker.sh?
Great question! r_linker is a r(esource) linker, created by a developer who does both Android and iOS development, and who misses his R.java class. It aims to make your life easier, by removing the need to type out NSStrings everywhere you reference static application assets.

# How do I use it?
I'm glad you asked! Here is a quick lesson:

###First, clone this repository!
`josh.oneal$ git clone https://github.com/LifeCoder45/r_linker.git`

###Next, open up your Xcode project and add 'r_linker.sh' to the Build Phases

- Click "Add Build Phase"
- Choose "Add Run Script"

![Add r_linker.sh to Xcode](https://github.com/LifeCoder45/r_linker/blob/master/images/add_script.png =900x)

- Add the path to the r_linker.sh that you just checked out, making sure to add the project directory and project name as **QUOTED** arguments.

- In my case: `/Users/josh.oneal/Projects/r_linker/r_linker.sh "$PROJECT_DIR" "$PROJECT_NAME"`

![Add r_linker.sh's path](https://github.com/LifeCoder45/r_linker/blob/master/images/add_shell.png =1000x)

- Next, build your project one time. If you check out your prefix header, you'll see a new import! We need to add that file to Xcode!

![Note the prefix addition](https://github.com/LifeCoder45/r_linker/blob/master/images/prefix_note.png =1000x)

- Lastly, we need to add the generated header file to your project. Be sure that when you're adding the file, you **DON'T COPY** it (leave copy unchecked). This is so subsequent builds will update the file. The header file is in `$PROJECT_NAME-Gen`, located in the root of the Xcode project directory.

![Note the prefix addition](https://github.com/LifeCoder45/r_linker/blob/master/images/add_header.png =1000x)

- That's it! Now you can rebuild the project as many times as you'd like.

![Note the prefix addition](https://github.com/LifeCoder45/r_linker/blob/master/images/gen_file.png =1000x)


# How do I /really/ use it?
Now it's time for the fun part.

Whenever you need to use an asset, whether it's a database file, an image, or a csv, just use the nice define'd constant, `r$FILENAME_WITH_UNDERSCORES`, rather that typing out the whole thing.

###Previously

`UIImage *anImage = [UIImage imageNamed:@"Default-586h@2x.png"]; // ugh`

###New and improved!

`UIImage *anImage = [UIImage imageNamed:rDefault_568h_2x_png]; // wow-wee!`

# What's next?
I'm not quite sure. I'd like to add some more seperation of the types of assets, and possible expand the patterns matched from what they are now. Be sure to let me know of any changes you'd like to see!