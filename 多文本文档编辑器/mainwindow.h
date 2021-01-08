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
    void on_actionLL_triggered();
    void on_action_L_triggered();
    void on_actionSA_triggered();
    void on_actionLetIn_triggered();
    void on_actionbold_triggered();
    void on_actionRedd_triggered();
    void on_actionYeloww_triggered();
    void on_actionGreenn_triggered();
    void on_actionBluee_triggered();
    void on_actionBlueee_triggered();
    void on_actionGreen_triggered();
    void on_actionYellowww_triggered();
    void on_actionmagenta_triggered();
    void on_actionlightGray_triggered();
    void on_actionitalic_triggered();
    void on_actionblue_triggered();
    void on_actiongreen_triggered();
    void on_actionred_triggered();
    void on_actiongrey_triggered();
    void on_action_4_triggered();
    void on_action_5_triggered();
    void on_action_6_triggered();
    void on_action_7_triggered();
    void on_action_8_triggered();
    void on_action_9_triggered();
    void on_action_10_triggered();
    void on_action_11_triggered();
    void on_action_12_triggered();
    void on_action1_triggered();
    void on_action10_triggered();
    void on_action20_triggered();
    void on_action30_triggered();
    void on_action40_triggered();
    void on_action25_triggered();
    void on_action26_triggered();
    void on_action27_triggered();
    void on_action28_2_triggered();
    void on_action29_triggered();
    void on_action30_2_triggered();
    void on_action31_triggered();
    void on_action32_triggered();
    void on_action33_triggered();
    void on_action34_triggered();
    void on_action35_triggered();
    void on_action36_triggered();
    void on_actionshx_triggered();
    void on_actionchangkou_triggered();
};

#endif // MAINWINDOW_H
