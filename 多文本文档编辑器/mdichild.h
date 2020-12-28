#ifndef MDICHILD_H
#define MDICHILD_H

#include <QTextEdit>
#include <QPushButton>

#include <QApplication>
#include <QFile>
#include <QMessageBox>
#include <QTextStream>
#include <QFileInfo>
#include <QFileDialog>
#include <QCloseEvent>

class MdiChild : public QTextEdit
{
    Q_OBJECT
public:
    explicit MdiChild(QWidget *parent = 0);

    void newFile();
    bool loadFile( const QString &filename);
    bool save();
    bool saveAs();
    bool saveFile(const QString &filename);
    QString userFriendlyCurrenFile();
    QString currentFile(){return curFile;}

private:
    QString curFile;
    bool isUntitled;
    void setCurrentFile(const QString &filename);
    bool maybeSave();

protected:
    void closeEvent(QCloseEvent *event);
    void contextMenuEvent(QContextMenuEvent *e);


    
signals:
    
public slots:
    void documentWasModified();

    
};

#endif // MDICHILD_H
