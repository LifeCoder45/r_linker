# What is r_linker.sh?
Great question! r_linker is a r(esource) linker, created by a developer who does both Android and iOS development, and who misses his R.java class. It aims to make your life easier, by removing the need to type out NSStrings everywhere you reference static application assets.

# How do I use it?
I'm glad you asked! Here is a quick lesson:

###First, clone this repository!
`josh.oneal$ git clone https://github.com/LifeCoder45/r_linker.git`

###Next, open up your Xcode project and add 'r_linker.sh' to the Build Phases

- Click "Add Build Phase"
- Choose "Add Run Script"

![Add r_linker.sh to Xcode](https://raw.github.com/LifeCoder45/r_linker/master/images/add_script.png)

- Add the path to the r_linker.sh that you just checked out, making sure to add the project directory and project name as **QUOTED** arguments.

- In my case: `/Users/josh.oneal/Projects/r_linker/r_linker.sh "$PROJECT_DIR" "$PROJECT_NAME"`

![Add r_linker.sh's path](https://raw.github.com/LifeCoder45/r_linker/master/images/add_shell.png)

- Next, build your project one time. If you check out your prefix header, you'll see a new import! We need to add that file to Xcode!

![Note the prefix addition](https://raw.github.com/LifeCoder45/r_linker/master/images/prefix_note.png)

- Lastly, we need to add the generated header file to your project. Be sure that when you're adding the file, you **DON'T COPY** it (leave copy unchecked). This is so subsequent builds will update the file. The header file is in `$PROJECT_NAME-Gen`, located in the root of the Xcode project directory.

![Note the prefix addition](https://raw.github.com/LifeCoder45/r_linker/master/images/add_header.png)

- That's it! Now you can rebuild the project as many times as you'd like.

![Note the prefix addition](https://raw.github.com/LifeCoder45/r_linker/master/images/gen_file.png)


# How do I /really/ use it?
Now it's time for the fun part.

Whenever you need to use an asset, whether it's a database file, an image, or a csv, just use the nice define'd constant, `r$FILENAME_WITH_UNDERSCORES`, rather that typing out the whole thing.

###Previously

`UIImage *anImage = [UIImage imageNamed:@"Default-586h@2x.png"]; // ugh`

###New and improved!

`UIImage *anImage = [UIImage imageNamed:rDefault_568h_2x_png]; // wow-wee!`

# What's next?
I'm not quite sure. I'd like to add some more seperation of the types of assets, and possible expand the patterns matched from what they are now. Be sure to let me know of any changes you'd like to see!

# License
    Copyright 2013 Josh O'Neal

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.