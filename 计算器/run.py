import tkinter
from tkinter import *
import tkinter.font as tkfont


class Calculator(object):
    """计算器"""

    def __init__(self):
        self.tk = tkinter.Tk()
        self.tk.title('计算器')
        self.tk.minsize(370, 460)
        self.tk.maxsize(400, 400)
        self.inputlist = []
        self.midstr = ''
        self.ButtonList = ['清空', '/', '*', '退格', 7, 8, 9, '-', 4, 5, 6, '+', 1, 2, 3, 0, '.', '=', '1/x', '%', 'sqrt']
        # 增加菜单
        self.menuBar = Menu(self.tk)
        self.tk.config(menu=self.menuBar)
        # 设置菜单选项
        aboutMenu = Menu(self.menuBar, tearoff=0)
        moreMenu = Menu(self.menuBar, tearoff=0)
        # 字体设置
        self.EntryFont = tkfont.Font(self.tk, size=13)
        self.ButtonFont = tkfont.Font(self.tk, size=12)
        # 面板显示
        self.count = tkinter.StringVar()
        self.count.set('0')
        self.label = tkinter.Label(self.tk, bg='#EEE9E9', bd='3', fg='black', anchor='center', font=self.EntryFont,
                                   textvariable=self.count)
        self.label.place(y=10, width=380, height=40)
        # 按钮设置
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#EE6A50', text=self.ButtonList[0],
                                        font=self.ButtonFont, command=self.clear)
        self.NumButton.place(x=30, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#BFEFFF', text=self.ButtonList[1],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[1]))
        self.NumButton.place(x=110, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#BFEFFF', text=self.ButtonList[2],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[2]))
        self.NumButton.place(x=190, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#EE6A50', text=self.ButtonList[3],
                                        font=self.ButtonFont, command=self.backspace)
        self.NumButton.place(x=270, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[4],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[4]))
        self.NumButton.place(x=30, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[5],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[5]))
        self.NumButton.place(x=110, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[6],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[6]))
        self.NumButton.place(x=190, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#BFEFFF', text=self.ButtonList[7],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[7]))
        self.NumButton.place(x=270, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[8],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[8]))
        self.NumButton.place(x=30, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[9],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[9]))
        self.NumButton.place(x=110, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[10],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[10]))
        self.NumButton.place(x=190, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#BFEFFF', text=self.ButtonList[11],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[11]))
        self.NumButton.place(x=270, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[12],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[12]))
        self.NumButton.place(x=30, y=260, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[13],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[13]))
        self.NumButton.place(x=110, y=260, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[14],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[14]))
        self.NumButton.place(x=190, y=260, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#CDBA96', text=self.ButtonList[15],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[15]))
        self.NumButton.place(x=30, y=320, width=150, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#EECFA1', text=self.ButtonList[16],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[16]))
        self.NumButton.place(x=190, y=320, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#E0EEE0', text=self.ButtonList[17],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[17]))
        self.NumButton.place(x=270, y=260, width=70, height=175)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#BFEFFF', text=self.ButtonList[18],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[18]))
        self.NumButton.place(x=30, y=380, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#BFEFFF', text=self.ButtonList[19],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[19]))
        self.NumButton.place(x=110, y=380, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#BFEFFF', text=self.ButtonList[20],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[20]))
        self.NumButton.place(x=190, y=380, width=70, height=55)

    # 清空
    def clear(self):
        self.inputlist = []
        self.midstr = ''
        self.count.set(0)

    # 退格
    def backspace(self):
        if self.inputlist == []:
            pass
        else:
            self.inputlist.pop()
            self.count.set(self.inputlist)

    # 判断计算符号
    def signCheck(self, sign):
        return sign in self.inputlist

    def checkList(self):
        result = 0
        locate = -1
        listSum = 0
        for length in range(0, len(self.inputlist)):
            if re.findall(r'[-+*/]', str(self.inputlist[length])):
                result = 1
                if length > locate:
                    locate = length
            else:
                pass
        if result == 1:
            for i in range(locate + 1, len(self.inputlist)):
                listSum += int(self.inputlist[i]) * (10 ** (len(self.inputlist) - i - 1))
        else:
            for j in range(0, len(self.inputlist)):
                listSum += int(self.inputlist[j]) * (10 ** (len(self.inputlist) - j - 1))
        return listSum, locate

    # 添加button
    def addButton(self, button):
        if button == self.ButtonList[18]:
            listSum, locate = self.checkList()
            if locate == -1:
                self.inputlist = [str(round(eval('1/' + str(listSum)), 5))]
            else:
                for k in range(locate + 1, len(self.inputlist)):
                    del self.inputlist[k]
                self.inputlist.append(str(round(eval('1/' + str(listSum)), 5)))
        elif button == self.ButtonList[19]:
            listSum, locate = self.checkList()
            if locate == -1:
                self.inputlist = [str(listSum * 0.01)]
            else:
                for k in range(locate + 1, len(self.inputlist)):
                    del self.inputlist[k]
                self.inputlist.append(str(listSum * 0.01))
        elif button == self.ButtonList[20]:
            listSum, locate = self.checkList()
            if locate == -1:
                self.inputlist = [str(round(listSum ** 0.5, 5))]
            else:
                for k in range(locate + 1, len(self.inputlist)):
                    del self.inputlist[k]
                self.inputlist.append(str(round(listSum ** 0.5, 5)))
        else:
            self.inputlist.append(button)
        self.count.set(self.inputlist)

    # 检查输入
    def inputCheck(self, input):
        if re.findall(r'[&a-zA-Z<>,?~!@#$";:]', str(input)):
            if input == '1/x' or input == '%' or input == 'sqrt':
                pass
            else:
                self.count.set('非法')

    # 按钮事件处理
    def knobDown(self, button):
        self.inputCheck(button)
        # inputlist为空时，检查输入的第一位是否为数字
        if self.inputlist == [] and re.findall(r'[-+*/=.%]', str(button)):
            self.count.set('符号不能放在第一位哦~')
        # 如果输入算符
        elif re.findall(r'[-+*/]', str(button)):
            # 判断inputlist里面是否有算符
            if self.signCheck('-') or self.signCheck('+') \
                    or self.signCheck('/') or self.signCheck('*'):
                if re.findall(r'[-+*/]', str(self.inputlist[-1])):
                    if button == '1/x' or button == '%':
                        pass
                    else:
                        self.count.set('不能连续输入算符')
                else:
                    self.addButton(button)
            else:
                self.addButton(button)
        # 输入等号时转化为str利用eval函数计算
        elif button == '=':
            if re.findall(r'[-+*/%]', str(self.inputlist[-1])):
                self.count.set('结尾不能是算符哦~')
            else:
                for length in range(0, len(self.inputlist)):
                    if str(self.inputlist[length]).isdigit():
                        self.midstr += str(self.inputlist[length])
                    else:
                        self.midstr = self.midstr + self.inputlist[length]
                self.inputCheck(self.midstr)  # eval函数很危险要严格过滤
                self.count.set(self.midstr + '=' + str(round(eval(self.midstr), 5)))
                self.inputlist = []
                self.midstr = ''
        else:
            self.addButton(button)

    def start(self):
        self.tk.mainloop()
if __name__ == '__main__':
    NewCalculator = Calculator()
    NewCalculator.start()
