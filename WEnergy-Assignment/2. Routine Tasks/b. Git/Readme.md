a)
To automatically run a script whenever a repository receives new commits through a push, you can use Git hooks feature. Git hooks are scripts that Git can execute at specific points during the repository's lifecycle. In this case, you can use the post-receive hook, which is triggered after new commits are received through a push.

Follow these steps to set up the post-receive hook:

- Locate the .git folder within the repository's directory. If hidden files are not visible, you might need to enable their display.

- Inside the .git folder, navigate to the hooks subdirectory.

- Create a new file named post-receive (without any file extension) within the hooks directory.

- Make the file executable by running the following command:

chmod +x post-receive

- Open the post-receive file through text editor and write a script that should be executed and save the file. Here you can use any scripting language such as Bash, Python, Ruby.

#!/bin/bash

echo "New commits received!"

Now, whenever someone pushes a new commit to the repository, the script "post-receive" hook will be automatically executed. 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

b)

To find a list of files that have changed in a particular commit, you can use the git diff command. 

git diff <commit_id>

The above command will show the detailed changes along with the file names for the specified commit. 

You can also use the below command to find the list of files changed in a specified commit. 

git diff --name-only <commit_id>