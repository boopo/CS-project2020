#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "mdichild.h"
#include <QAction>
#include <QMdiSubWindow>
#include <QSignalMapper>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    
private:
    Ui::MainWindow *ui;
    QAction *actionSeparator;
    MdiChild *activeMdiChild();

    QMdiSubWindow *findMdiChild(const QString &filename);
    QSignalMapper *windowMapper;

    void initWindow();


private slots:
    void newButtonSlot();
    void openButtonSlot();
    void setActiveSubWindow(QWidget *window);
    void updateMenus();

    void updateWindowMenu();

    void on_actionSave_triggered();
    void on_actionUndo_triggered();
    void on_actionRedo_triggered();
    void on_actionCut_triggered();
    void on_actionCopy_triggered();
    void on_actionPaste_triggered();
    void on_actionClose_triggered();

    void showTextRowAndCol();
};

#endif // MAINWINDOW_H
