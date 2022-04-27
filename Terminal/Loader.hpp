#ifndef LOADER_HPP_
#define LOADER_HPP_
#include <fstream>
#include <iostream>
#include <memory>

class Terminal;

class Loader{
public:
    Loader(Directory*);
    ~Loader();
    void open(Directory*_root);
    void close(Directory* _root);

    std::string                _txt_name{"data.txt"};
private:
    void read(Directory* _root);
    void write(Directory* _root);
    std::ifstream              _fin;
    std::ofstream              _fout;
    Directory*                 _root;
};

Loader::Loader(Directory* root)
:_root{root}
{
    open(_root);
}

Loader::~Loader()
{
    _fin.close();
    _fout.open(_txt_name);
    close(_root);
    _fout.close();
}

void Loader::open(Directory* _root){
    _fin.open(_txt_name);
    read(_root);
}

void Loader::write(Directory* _root){
    if(!_root){
        return;
    }
    if(_root->_directories.size()!=0){
    _fout<<"{ ";
        for(int i{};i < _root->_directories.size();++i){
        _fout <<'d';
        _fout <<_root->_directories[i]->getName();
        _fout <<' ';
    }
        _fout<<" }";
    }
    if(_root->_files.size()!=0){
    for(int i{};i < _root->_files.size();++i){
        _fout <<'f';
        _fout <<_root->_files[i]->getName();
        _fout <<' ';
    }
}
    
    for(int i{};i < _root->_directories.size();++i){
        
        write(_root->_directories[i].get());
    }
    
    
}

void Loader::read(Directory* _root){//read petqa ogtagorxci
    std::string word;
    if(_fin.is_open())
    {
        while(!_fin.eof()){
            _fin>>word;

            if(word == "{"){
                _fin>>word;
            }
                if(word[0]=='d'){
                    std::shared_ptr<Directory> ptr(new Directory(word.substr(1,word.size()),_root));
                    _root->_directories.push_back(ptr);
                }
                else if(word[0]=='f'){
                    std::shared_ptr<File> ptr(new File(word.substr(1,word.size())));
                    _root->_files.push_back(ptr);
                }
            else if(word =="}" && !_root->_previous){
                _root=_root->_previous;
            }
                
        }

        
    }
}

void Loader::close(Directory* _root){
    if(!_root){
        return;
    }
    this->write(_root);
    /*for(int i{};i<_root->_directories.size();++i)
    {
        
    }*/
}

#endif 
