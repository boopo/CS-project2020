#include "mainwindow.h"
#include "ui_mainwindow.h"
 #include <QLabel>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    setWindowTitle(trUtf8("欢迎使用多文档编辑器"));
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

    actionSeparator->setVisible(hasMdiChild);

    bool hasSelection = ( activeMdiChild()  &&  activeMdiChild()->textCursor().hasSelection() );
    ui->actionCut->setEnabled(hasSelection);
    ui->actionCopy->setEnabled(hasSelection);

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
        int rowNum = activeMdiChild()->textCursor().blockNumber() + 1;
        int colNum = activeMdiChild()->textCursor().columnNumber()+1;

        ui->statusBar->showMessage(trUtf8("%1行 %2列").arg(rowNum).arg(colNum),2000);

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
