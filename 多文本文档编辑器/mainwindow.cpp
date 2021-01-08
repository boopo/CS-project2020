#include "mainwindow.h"
#include "ui_mainwindow.h"
 #include <QLabel>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    setWindowTitle(trUtf8("多文档文档编辑器"));
    actionSeparator = new QAction(this);
    actionSeparator->setSeparator(true);
    updateMenus();
    connect(ui->mdiArea,SIGNAL(subWindowActivated(QMdiSubWindow*)),this,SLOT(updateMenus()));

    QObject::connect(ui->actionNew,SIGNAL(triggered()),this,SLOT(newButtonSlot()));
    QObject::connect(ui->actionOpen,SIGNAL(triggered()),this,SLOT(openButtonSlot()));
    QObject::connect(ui->actionExit,SIGNAL(triggered()),this,SLOT(close()));

    windowMapper = new QSignalMapper(this);
    connect(windowMapper,SIGNAL(mapped(QWidget*)),this,SLOT(setActiveSubWindow(QWidget*)));
    updateWindowMenu();
    connect(ui->menuW,SIGNAL(aboutToShow()),this,SLOT(updateWindowMenu()));
    initWindow();
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::newButtonSlot()
{
    MdiChild *child = new MdiChild;

    ui->mdiArea->addSubWindow(child);

    connect(child, SIGNAL(copyAvailable(bool)),ui->actionCut,SLOT(setEnabled(bool)));
    connect(child,SIGNAL(copyAvailable(bool)),ui->actionCopy,SLOT(setEnabled(bool)));
    connect(child->document(),SIGNAL(undoAvailable(bool)),ui->actionUndo,SLOT(setEnabled(bool)));
    connect(child->document(),SIGNAL(redoAvailable(bool)),ui->actionRedo,SLOT(setEnabled(bool)));
    connect(child,SIGNAL(cursorPositionChanged()),this,SLOT(showTextRowAndCol()));
    child->newFile();
    child->show();
}

void MainWindow::openButtonSlot()
{
    QString filename = QFileDialog::getOpenFileName(this);
    if(!filename.isEmpty())
    {
        QMdiSubWindow *existing = findMdiChild(filename);
        if(existing)
        {
            ui->mdiArea->setActiveSubWindow(existing);
            return ;
        }
        MdiChild *child = new MdiChild;

        ui->mdiArea->addSubWindow(child);

        connect(child, SIGNAL(copyAvailable(bool)),ui->actionCut,SLOT(setEnabled(bool)));
        connect(child,SIGNAL(copyAvailable(bool)),ui->actionCopy,SLOT(setEnabled(bool)));
        connect(child->document(),SIGNAL(undoAvailable(bool)),ui->actionUndo,SLOT(setEnabled(bool)));
        connect(child->document(),SIGNAL(redoAvailable(bool)),ui->actionRedo,SLOT(setEnabled(bool)));

        if(child->loadFile(filename))
        {
            ui->statusBar->showMessage(trUtf8("打开文件成功"),2000);
            child->show();
        }
        else
        {
            child->close();
        }
    }
}

QMdiSubWindow* MainWindow::findMdiChild(const QString &filename)
{
    QString canonicalFilePath = QFileInfo(filename).canonicalFilePath();
    foreach(QMdiSubWindow *window, ui->mdiArea->subWindowList())
    {
        MdiChild *mdiChild = qobject_cast<MdiChild *>(window->widget());
        if(mdiChild->currentFile()==canonicalFilePath)
            return window;
    }
    return 0;
}

void MainWindow::setActiveSubWindow(QWidget *window)
{
    if(!window)
        return ;
    ui->mdiArea->setActiveSubWindow(qobject_cast<QMdiSubWindow *>(window));
}


void MainWindow::updateMenus()
{
    bool hasMdiChild = (activeMdiChild()!=0);

    ui->actionSave->setEnabled(hasMdiChild);
    ui->actionSaveAs->setEnabled(hasMdiChild);
    ui->actionPaste->setEnabled(hasMdiChild);
    ui->actionClose->setEnabled(hasMdiChild);
    ui->actionCloseAll->setEnabled(hasMdiChild);
    ui->actionTile->setEnabled(hasMdiChild);
    ui->actionCascade->setEnabled(hasMdiChild);
    ui->actionNext->setEnabled(hasMdiChild);
    ui->actionPrevious->setEnabled(hasMdiChild);
  //  ui->actionLL->setEnabled(hasMdiChild);
    actionSeparator->setVisible(hasMdiChild);

    bool hasSelection = ( activeMdiChild()  &&  activeMdiChild()->textCursor().hasSelection() );
    ui->actionCut->setEnabled(hasSelection);
    ui->actionCopy->setEnabled(hasSelection);
  //  ui->actionLL->setEnabled(hasSelection);

    ui->actionUndo->setEnabled(activeMdiChild() && activeMdiChild()->document()->isUndoAvailable());
    ui->actionRedo->setEnabled(activeMdiChild()&&activeMdiChild()->document()->isRedoAvailable());


}

MdiChild *MainWindow::activeMdiChild()
{
    if(QMdiSubWindow *activeSubWindow = ui->mdiArea->activeSubWindow())
        return qobject_cast<MdiChild *>(activeSubWindow->widget());
    return 0;
}

void MainWindow::updateWindowMenu()
{
    ui->menuW->clear();
    ui->menuW->addAction(ui->actionClose);
    ui->menuW->addAction(ui->actionCloseAll);
    ui->menuW->addSeparator();
    ui->menuW->addAction(ui->actionTile);
    ui->menuW->addAction(ui->actionCascade);
    ui->menuW->addSeparator();
    ui->menuW->addAction(ui->actionNext);
    ui->menuW->addAction(ui->actionPrevious);
    ui->menuW->addAction(actionSeparator);

    QList<QMdiSubWindow *>windows = ui->mdiArea->subWindowList();
    actionSeparator->setVisible(!windows.isEmpty());
    for(int i=0; i<windows.size();++i)
    {
        MdiChild *child = qobject_cast<MdiChild *>(windows.at(i)->widget());
        QString text;
        if(i<9)
        {
            text=trUtf8("&%1 %2").arg(i+1).arg(child->userFriendlyCurrenFile());
        }
        else
        {
            text=trUtf8("&%1 %2").arg(i+1).arg(child->userFriendlyCurrenFile());
        }
        QAction *action = ui->menuW->addAction(text);
        action->setCheckable(true);

        action->setChecked(child==activeMdiChild());
        connect(action,SIGNAL(triggered()),windowMapper,SLOT(map()));
        windowMapper->setMapping(action,windows.at(i));
    }
}

void MainWindow::on_actionSave_triggered()
{
    if(activeMdiChild()&&activeMdiChild()->save())
        ui->statusBar->showMessage(trUtf8("文件保存成功"),2000);
}

void MainWindow::on_actionUndo_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->undo();
}

void MainWindow::on_actionRedo_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->redo();
}

void MainWindow::on_actionCut_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->cut();
}

void MainWindow::on_actionCopy_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->copy();
}

void MainWindow::on_actionPaste_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->paste();
}








void MainWindow::on_actionClose_triggered()
{
    ui->mdiArea->closeActiveSubWindow();
}



void MainWindow::showTextRowAndCol()
{


    if(activeMdiChild())
    {
        int rowNum = activeMdiChild()->textCursor().blockNumber();
        int colNum = activeMdiChild()->textCursor().columnNumber()+1;
        int result = activeMdiChild()->toPlainText().length();

        ui->statusBar->showMessage(trUtf8("第%1行 第%2列 共%3字").arg(rowNum).arg(colNum).arg(result),2000);
    }

}


void MainWindow::initWindow()
{


    ui->mainToolBar->setWindowTitle(trUtf8("工具栏"));

    ui->mdiArea->setHorizontalScrollBarPolicy(Qt::ScrollBarAsNeeded);
    ui->mdiArea->setVerticalScrollBarPolicy(Qt::ScrollBarAsNeeded);

    ui->statusBar->showMessage(trUtf8("欢迎使用多文档编辑器"),2000);
    QLabel *label = new QLabel(this);
    label->setFrameStyle(QFrame::Box | QFrame::Sunken );
    ui->statusBar->addPermanentWidget(label);
    ui->actionNew->setStatusTip(trUtf8("创建一个文件"));

}



void MainWindow::on_action_L_triggered() //清空
{
    if(activeMdiChild())
        activeMdiChild()->clear();
}

void MainWindow::on_actionLL_triggered() //下划线
{
    bool tttt =1;
    if(activeMdiChild())
        activeMdiChild()->setFontUnderline(tttt);
}

void MainWindow::on_actionSA_triggered() //全选
{
    if(activeMdiChild())
        activeMdiChild()->selectAll();
}
QString s ="#Hello,World!";
void MainWindow::on_actionLetIn_triggered() //插入
{
    if(activeMdiChild())
        activeMdiChild()->insertPlainText(s);
}

void MainWindow::on_actionbold_triggered() // 加粗
{
    if(activeMdiChild())
        activeMdiChild()->setFontWeight(75);
}


void MainWindow::on_actionitalic_triggered()
{
    bool tt =1;
    if(activeMdiChild())
        activeMdiChild()->setFontItalic(tt);
}




void MainWindow::on_actionRedd_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::red);

}

void MainWindow::on_actionYeloww_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::yellow);
}

void MainWindow::on_actionGreenn_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::green);
}

void MainWindow::on_actionBluee_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::blue);
}

void MainWindow::on_actionBlueee_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::darkBlue);
}

void MainWindow::on_actionGreen_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::darkGreen);
}

void MainWindow::on_actionYellowww_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::darkYellow);
}

void MainWindow::on_actionmagenta_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::magenta);
}

void MainWindow::on_actionlightGray_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextBackgroundColor(Qt::lightGray);
}





void MainWindow::on_actionblue_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextColor(Qt::blue);
}

void MainWindow::on_actiongreen_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextColor(Qt::green);
}

void MainWindow::on_actionred_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextColor(Qt::red);
}

void MainWindow::on_actiongrey_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setTextColor(Qt::lightGray);
}

void MainWindow::on_action_4_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("微软雅黑");
}

void MainWindow::on_action_5_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("SimSun-ExtB");
}

void MainWindow::on_action_6_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("微软雅黑");
}

void MainWindow::on_action_7_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("Angsana New");
}

void MainWindow::on_action_8_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("Cordia New");
}

void MainWindow::on_action_9_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("幼圆");
}

void MainWindow::on_action_10_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("楷体");
}

void MainWindow::on_action_11_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("隶书");
}

void MainWindow::on_action_12_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontFamily("仿宋");
}

void MainWindow::on_action1_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(20);
}

void MainWindow::on_action10_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(21);
}

void MainWindow::on_action20_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(22);
}

void MainWindow::on_action30_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(23);
}

void MainWindow::on_action40_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(24);
}

void MainWindow::on_action25_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(25);
}

void MainWindow::on_action26_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(26);
}

void MainWindow::on_action27_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(27);
}

void MainWindow::on_action28_2_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(28);
}

void MainWindow::on_action29_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(29);
}

void MainWindow::on_action30_2_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(30);
}

void MainWindow::on_action31_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(31);
}

void MainWindow::on_action32_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(32);
}

void MainWindow::on_action33_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(33);
}

void MainWindow::on_action34_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(34);
}

void MainWindow::on_action35_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(35);
}

void MainWindow::on_action36_triggered()
{
    if(activeMdiChild())
        activeMdiChild()->setFontPointSize(36);
}

void MainWindow::on_actionshx_triggered()
{
    //bool tttt =1;
    if(activeMdiChild())
        activeMdiChild()->setStyleSheet("text-decoration: line-through;");
}

void MainWindow::on_actionchangkou_triggered()
{
    bool hj =1;
    //if(activeMdiChild())
         //activeMdiChild()->setTextCursor();
}
