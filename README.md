# An example of configuring Ollama

./server -- startup scripts for the server
./client -- scripts for generating config files for pi and opencode

My gpu capable machine happens to run Windows so I installed ollama serve inside
nssm.  Within this utility is set the enviroment variables as specified in 
server/env.bat

I also do most of my work on that machine in wsl 2 running Ubuntu.  I have
to set my OLLAMA_HOST to my WSL 2 gateway address when running ollama inside
of WSL 2.  You can use http://0.0.0.0:11434 if networkMode=mirrored is turned on
in the windows %USER_PROFILE%\.wslconfig

My main development laptop runs Arch Linux (Omarchy) and sets OLLAMA_HOST
to the network address of my Windows machine.  

Note that you will have to open up the incoming port (default 11434) on 
Windows to gain access to the ollama server.  This can be done within
your firewall software.


