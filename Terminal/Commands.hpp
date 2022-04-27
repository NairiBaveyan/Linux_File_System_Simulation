#ifndef COMMANDS_HPP_
#define COMMANDS_HPP_
#include <iostream>


class Directory;
extern std::vector<std::string>  _console;

template <typename T>
void print(std::vector<T>& vec){
    for(auto& el:vec){
        std::cout<<el<<'/';
    }
    std::cout<<std::endl;
}


class Commands{
public:
    Commands();
    ~Commands();
    bool check(int,std::string,Directory *&);
    std::pair<int,std::string> analyzer(std::string&);
    
private:

    static void ls(std::string option,Directory*&);
    static void mkdir(std::string option,Directory*&);
    static void cd(std::string option,Directory*&);
    static void touch(std::string option,Directory*&);
    static void rm(std::string option,Directory*&);
    static void rmdir(std::string option,Directory*&);
    static void pwd(std::string option,Directory*&);


private:
    static const int _size = 7;
    void (*_commands[7])(std::string,Directory*&);
};

void Commands::ls(std::string option,Directory* &_root){                      //ls
    _root->printInConsole();
}

void Commands::mkdir(std::string option,Directory* &_root){                   //mkdir
    std::shared_ptr<Directory> ptr(new Directory(option,_root));
    _root->_directories.push_back(ptr);
}

void Commands::cd(std::string option,Directory* &_root){                      //cd
    if(option==".."){
        if(_root->_previous){
            _root = _root->_previous;
            _console.pop_back();
        }
    }
    else if(_root){
        bool flag = false;
        for(int i{};i < _root->_directories.size();++i){
            if(option == _root->_directories[i]->getName()){
                _root->_directories[i]->set(_root);
                _root = _root->_directories[i].get();
                flag = true;
                _console.push_back(_root->getName());
            }
        }
        if(!flag)
            std::cout<<"wrong directory name\n";
    }
}

void Commands::touch(std::string option,Directory* &_root){                      //touch
    std::shared_ptr<File> ptr(new File(option));
    _root->_files.push_back(ptr);
}

void Commands::rm(std::string option,Directory* &_root){                      //rm
    for(int i{};i < _root->_files.size();++i)
    {   
        if(_root->_files[i]->getName()==option)
           _root->_files.erase(_root->_files.begin()+i);  
    }
}

void Commands::rmdir(std::string option,Directory* &_root){                      //rmdir
    for(int i{};i < _root->_directories.size();++i)
    {   
        if(_root->_directories[i]->getName()==option)
           _root->_directories.erase(_root->_directories.begin()+i);
        
    }
}

void Commands::pwd(std::string option,Directory* &_root){                      //pwd
    print(_console);
}

bool Commands::check(int index,std::string option,Directory *&_root){
    if(index == -1 || index >= _size)
        return false; 
    else{
        _commands[index](option,_root);
    }
    return true;
}

std::pair<int,std::string> Commands::analyzer(std::string &command)
{
    if(command == "ls")
        return std::make_pair(0,"");
    //ls end 0
    if(command.substr(0,5)=="mkdir"){
        if(command.size()<=6)
        {
            std::cout<<" enter the name of directory"<<std::endl;
            return std::make_pair(-1,"");
        }
        if(command[5] ==' '){
            return std::make_pair(1,command.substr(6,command.size()));
        }
    }
    //mkdir end 1
    if(command.substr(0,2)=="cd"){
        if(command.size()<=3)
        {
            std::cout<<"enter the name of directory"<<std::endl;
            return std::make_pair(-1,"");
        }
        if(command.size() > 3 && command[2] == ' '){
            return std::make_pair(2,command.substr(3,command.size()));
        }
    }
    //cd end 2
    if(command.substr(0,5) == "touch"){
        if(command.size()<=6)
        {
            std::cout<<"enter the name of file"<<std::endl;
            return std::make_pair(-1,"");
        }
        if(command[5] ==' '){
            return std::make_pair(3,command.substr(6,command.size()));
        }
    }
    //touch end 3
    if(command.substr(0,2)=="rm"){
        if(command.size()<=3)
        {
            std::cout<<"enter the name of file"<<std::endl;
            return std::make_pair(-1,"");
        }
        if(command.size() > 3 && command[2] == ' '){
            return std::make_pair(4,command.substr(3,command.size()));
        }
    }
    //rm end 4
    if(command.substr(0,5)=="rmdir"){
        if(command.size()<=6)
        {
            std::cout<<"enter the name of directory"<<std::endl;
            return std::make_pair(-1,"");
        }
        if(command[5] ==' ')
            return std::make_pair(5,command.substr(6,command.size()));
    } 
    //rmdir end 5
    if(command == "pwd")
        return std::make_pair(6,"");
    //pwd end 6
    return std::make_pair(-1,"");
}

Commands::~Commands()
{

}

Commands::Commands()
{
    //commands
    _commands[0] = &Commands::ls;
    _commands[1] = &Commands::mkdir;
    _commands[2] = &Commands::cd;
    _commands[3] = &Commands::touch;
    _commands[4] = &Commands::rm;
    _commands[5] = &Commands::rmdir;
    _commands[6] = &Commands::pwd;
}

#endif