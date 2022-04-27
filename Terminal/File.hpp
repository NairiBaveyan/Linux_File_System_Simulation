#ifndef FILE_HPP_
#define FILE_HPP_
#include <string>
#include <iostream>

class File{
public:
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

#endif