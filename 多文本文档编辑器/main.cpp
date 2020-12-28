#include <QApplication>
#include "mainwindow.h"
#include <QTextCodec>

int main(int argc, char *argv[])
{
    QApplication::addLibraryPath("/usr/local/Trolltech/Qt-4.8.6/plugins");
    QApplication a(argc, argv);
    MainWindow w;

    QTextCodec *codec = QTextCodec::codecForName("System");
    //获取系统编码
    QTextCodec::setCodecForLocale(codec);
    QTextCodec::setCodecForCStrings(codec);
    QTextCodec::setCodecForTr(codec);

    QFont font;
    font.setPointSize(20);
    font.setBold(false);
    a.setFont(font);
    w.show();
    
    return a.exec();
}
