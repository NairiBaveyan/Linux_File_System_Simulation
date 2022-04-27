#ifndef TERMINAL_HPP_
#define TERMINAL_HPP_
#include <iostream>
#include <string>
#include <vector>
#include "Directory.hpp"
#include "Commands.hpp"
#include "Loader.hpp"
//#include "File.hpp"


class Terminal{

Loader*        _loader;
public:
    friend class Commands;
    Terminal();
    ~Terminal();
    Terminal(const Terminal& rhs) = delete;
    Terminal& operator=(const Terminal& rhs)= delete;
    Terminal& operator=(Terminal&&) = delete;
    Terminal(Terminal&&) = delete;

private:

    void RUN();
    void checkCommand(std::string&);
    
private:

    std::vector<std::string>     _com_vec;
    std::string                  _command;
    Directory*                   _root;
    Commands                     _commands_;

};//end of Terminal
std::vector<std::string>  _console{"WelcomeToHoktemberyan :D$"};

std::ostream& operator<<(std::ostream& os,std::vector<std::string>& vec){
    for(auto& elem:vec)
    {
        os<<elem;
        os<<'/';
    }
    return os;
}


Terminal::Terminal() :
_root{new Directory("WelcomeToHoktemberyan :D$ ",nullptr)}

{ 
    _loader = new Loader(_root);
    system("clear");
    RUN();
}

Terminal::~Terminal()
{
    delete _loader;
    delete _root;
}

void Terminal::RUN(){
    //loop
    while(true){
        std::cout<<_console;
        std::getline(std::cin,_command);
        int cur{},prev{};
        if((_command=="exit") || (_command=="close")){
        std::cout<<"Bye-Bye"<<std::endl;
        return;
        }
        checkCommand(_command);
    }
}

void Terminal::checkCommand(std::string &command){
    /*if((command=="exit") || (command=="close")){
        std::cout<<"Bye-Bye"<<std::endl;
        std::abort();
    }*/
    
    auto pair = _commands_.analyzer(command);
    int index = pair.first;
    std::string option = pair.second;
    bool flag = _commands_.check(index,option,_root);
    if(flag==false){
        std::cout<<"wrong command"<<std::endl;
        return;
    }
}


#endif //TERMINAL_HPP_