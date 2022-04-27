#ifndef DIRECTORY_H_
#define DIRECTORY_H_    
#include <iostream>
#include <vector>
#include <memory>


class File{
public:
    friend class Loader;
    File(std::string name);
    ~File() = default;
    friend std::ostream& operator<<(std::ostream& os,File &file);
    std::string getName(){return _file_name;}

private:
    std::string _file_name;
};

std::ostream& operator<<(std::ostream& os,File &file){
    os<<file._file_name;
    return os;
}

File::File(std::string name)
:_file_name{name}
{
}

class Directory{
    friend class Loader;
    friend class Commands;

public:
    Directory(std::string ,Directory*);
    friend std::ostream& operator<<(std::ostream& os,Directory& dir);
    void printInConsole();
    std::string getName(){return _dir_name;}
    void set(Directory* prev);

private:
    
    Directory*                                  _current;
    Directory*                                  _previous;
    std::vector <std::shared_ptr<Directory> >  _directories;
    std::vector <std::shared_ptr<File> >       _files;
    std::string                                _dir_name;
};


void Directory::set(Directory* prev){
    this->_previous = prev;
    this->_current = this;
}

void Directory::printInConsole(){
    std::cout<<std::endl;
    for(int i{};i < _directories.size();++i){
        std::cout<<*_directories[i] <<"   ";
    }
    for(int i{};i < _files.size();++i){
        std::cout<<*_files[i] <<"   ";
    }
    std::cout<<std::endl;

}

std::ostream& operator<<(std::ostream& os,Directory& dir)
{
    os<< dir._dir_name;
    return os;
}

Directory::Directory(std::string dir_name,Directory* prev)
:_dir_name{dir_name}, _previous{prev}
{
    _current = this;
}

#endif