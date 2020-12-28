#include "mdichild.h"
#include <QMenu>
#include <QKeySequence>

MdiChild::MdiChild(QWidget *parent) :
    QTextEdit(parent)
{
    setAttribute(Qt::WA_DeleteOnClose);
    isUntitled = true;
}

void MdiChild::closeEvent(QCloseEvent *event)
{
    //如果maybeSave()函数返回为真，则关闭窗口。
    if(maybeSave())
        event->accept();
    else
        event->ignore();
}

void MdiChild::newFile()
{
    //设置窗口编号
    static int sequenceNumber = 1;

    //设置文件未被保存过
    isUntitled = true;

    //设置子窗口标题
    curFile = trUtf8("未命名文档%1.txt").arg(sequenceNumber++);
    setWindowTitle(curFile +trUtf8("-多文档编辑器")+"*");

    //关联文档内容改变信号到显示文档更改状态标志槽
    connect(document(),SIGNAL(contentsChange(int,int,int)),this,SLOT(documentWasModified()));

}

void MdiChild::documentWasModified()
{
    if(  isUntitled  )
        setWindowTitle(curFile +trUtf8("-多文档编辑器")+ "*");
   else
        setWindowTitle(curFile +trUtf8("-多文档编辑器"));
}

bool MdiChild::loadFile(const QString &filename)
{
    QFile file(filename);

    if(!file.open(QFile::ReadOnly|QFile::Text))
    {
        QMessageBox::warning(this,trUtf8("多文本编辑器"),trUtf8("无法读取文件 %1:%2.").arg(filename).arg(file.errorString()));
        return false;
    }
    QTextStream in(&file);
    QApplication::setOverrideCursor(Qt::WaitCursor);
    setPlainText(in.readAll());
    QApplication::restoreOverrideCursor();
    setCurrentFile(filename);
    connect(document(),SIGNAL(contentsChange(int,int,int)),this,SLOT(documentWasModified()));
    return true;
}

void MdiChild::setCurrentFile(const QString &filename)
{
    curFile = QFileInfo(filename).canonicalFilePath();
    isUntitled = false;
    document()->setModified(false);
    setWindowModified(false);
    setWindowTitle(userFriendlyCurrenFile()+"[*]");
}

QString MdiChild::userFriendlyCurrenFile()
{
    return QFileInfo(curFile).fileName();
}

bool MdiChild::save()
{
    //如果文件没有被保存过，执行另存为操作
    //否则执行保存。该函数应先打开指定文件，然后将编辑器的内容写入到文件，最后设置当前文件。
    if(isUntitled)
        return saveAs();
    else
        return saveFile(curFile);
}

bool MdiChild::saveAs()
{
    //从文件对话框获取文件路径
    QString fileName = QFileDialog::getSaveFileName(this,trUtf8("另存为"),curFile);

    //如果路径不为空，则保存文件saveFile()
    if(fileName.isEmpty())
        return false;
    return saveFile(fileName);


    return true;
}


bool MdiChild::saveFile(const QString &filename)
{
    QFile file(filename);
    if( !file.open(QFile::WriteOnly|QFile::Text))
    {
        QMessageBox::warning(this,trUtf8("多文档编辑器"),trUtf8("无法写入文件%1:\n%2.").arg(filename).arg(file.errorString()));
        return false;
    }
    QTextStream out(&file);
    QApplication::setOverrideCursor(Qt::WaitCursor);
    out<<toPlainText();
    QApplication::restoreOverrideCursor();
    setCurrentFile(filename);
    return true;
}

bool MdiChild::maybeSave()
{
    if(document()->isModified())
    {
        QMessageBox box;
        box.setWindowTitle(trUtf8("多文本编辑器"));
        box.setText(trUtf8("是否保存对%1的更改？").arg(userFriendlyCurrenFile()));
        box.setIcon(QMessageBox::Warning);

        QPushButton *yesButton = box.addButton(trUtf8("是(&Y)"),QMessageBox::YesRole);
        box.addButton(trUtf8("否(&N)"),QMessageBox::NoRole);
        QPushButton *cancelButton = box.addButton(trUtf8("取消"),QMessageBox::RejectRole);
        box.exec();
        if(box.clickedButton()==yesButton)
            return save();
        else if(box.clickedButton()==cancelButton)
            return false;
    }
    return true;
}

void MdiChild::contextMenuEvent(QContextMenuEvent *e)
{
    QMenu *menu = new QMenu;
    QAction *undo = menu->addAction(trUtf8("撤销(&U)"),this,SLOT(undo()),QKeySequence::Undo);
    undo->setEnabled(document()->isUndoAvailable());
    QAction *redo = menu->addAction(trUtf8("恢复(&R)"),this,SLOT(redo()),QKeySequence::Redo);
    redo->setEnabled(document()->isRedoAvailable());
    menu->addSeparator();
    QAction *cut = menu->addAction(trUtf8("剪切(&T)"),this,SLOT(cut()),QKeySequence::Cut);
    cut->setEnabled(textCursor().hasSelection());
    QAction *copy = menu->addAction(trUtf8("复制(&C)"),this,SLOT(copy()),QKeySequence::Copy);
    copy->setEnabled(textCursor().hasSelection());
    menu->addAction(trUtf8("粘贴(&P)"),this,SLOT(paste()),QKeySequence::Paste);
    QAction *clear = menu->addAction(trUtf8("清空"),this,SLOT(clear()));
    clear->setEnabled(!document()->isEmpty());
    menu->addSeparator();
    QAction *select = menu->addAction(trUtf8("全选"),this,SLOT(selectAll()),QKeySequence::SelectAll);
    select->setEnabled(!document()->isEmpty());

    menu->exec(e->globalPos());
    delete menu;

}





