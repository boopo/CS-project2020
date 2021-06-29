import tkinter
from fractions import Fraction
from tkinter import *
import tkinter.font as tkfont

'''
@Author Boopo 
'''


class Calculator(object):

    def __init__(self):
        self.tk = tkinter.Tk()
        self.tk.title('计算器')
        self.tk.minsize(370, 460)
        self.tk.maxsize(400, 400)
        self.inputlist = []
        self.midstr = ''
        self.ButtonList = ['清空', '/', '*', '退格', 7, 8, 9, '-', 4, 5, 6, '+', 1, 2, 3, 0, '.', '=', '1/x', '%', 'sqrt',
                           '(', ')']

        self.menuBar = Menu(self.tk)
        self.tk.config(menu=self.menuBar)

        aboutMenu = Menu(self.menuBar, tearoff=0)
        moreMenu = Menu(self.menuBar, tearoff=0)
        self.menuBar.add_cascade(label='贷款计算', command=startDaikuan)
        self.menuBar.add_cascade(label='保险金计算', command=startBaoxian)
        self.menuBar.add_cascade(label='利息计算', command=startRate)

        self.EntryFont = tkfont.Font(self.tk, size=13)
        self.ButtonFont = tkfont.Font(self.tk, size=12)

        self.count = tkinter.StringVar()
        self.count.set('0')
        self.label = tkinter.Label(self.tk, bg='#FFFFFF', bd='3', fg='black', anchor='center', font=self.EntryFont,
                                   textvariable=self.count)
        self.label.place(y=10, width=380, height=40)

        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FF3300', text=self.ButtonList[0],
                                        font=self.ButtonFont, command=self.clear)
        self.NumButton.place(x=30, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[1],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[1]))
        self.NumButton.place(x=110, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[2],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[2]))
        self.NumButton.place(x=190, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[3],
                                        font=self.ButtonFont, command=self.backspace)
        self.NumButton.place(x=270, y=80, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[4],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[4]))
        self.NumButton.place(x=30, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[5],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[5]))
        self.NumButton.place(x=110, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[6],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[6]))
        self.NumButton.place(x=190, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[7],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[7]))
        self.NumButton.place(x=270, y=140, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[8],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[8]))
        self.NumButton.place(x=30, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[9],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[9]))
        self.NumButton.place(x=110, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[10],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[10]))
        self.NumButton.place(x=190, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[11],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[11]))
        self.NumButton.place(x=270, y=200, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[12],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[12]))
        self.NumButton.place(x=30, y=260, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[13],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[13]))
        self.NumButton.place(x=110, y=260, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[14],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[14]))
        self.NumButton.place(x=190, y=260, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[15],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[15]))
        self.NumButton.place(x=30, y=320, width=150, height=55)

        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[16],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[16]))
        self.NumButton.place(x=190, y=320, width=70, height=55)  # 。

        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[21],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[21]))
        self.NumButton.place(x=270, y=320, width=70, height=55)  # (

        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[22],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[22]))
        self.NumButton.place(x=270, y=380, width=70, height=55)  # )

        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[17],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[17]))
        self.NumButton.place(x=270, y=260, width=70, height=55)  # =

        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[18],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[18]))
        self.NumButton.place(x=30, y=380, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[19],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[19]))
        self.NumButton.place(x=110, y=380, width=70, height=55)
        self.NumButton = tkinter.Button(master=self.tk, relief=GROOVE, bg='#FFFFFF', text=self.ButtonList[20],
                                        font=self.ButtonFont, command=lambda: self.knobDown(self.ButtonList[20]))
        self.NumButton.place(x=190, y=380, width=70, height=55)

    def clear(self):
        self.inputlist = []
        self.midstr = ''
        self.count.set(0)

    # <-
    def backspace(self):
        if self.inputlist == []:
            pass
        else:
            self.inputlist.pop()
            self.count.set(self.inputlist)

    # 判断符号
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

        if self.inputlist == [] and re.findall(r'[-+*/=.%]', str(button)):
            self.count.set('符号不能放在第一位')
        # 如果输入算符
        elif re.findall(r'[-+*/]', str(button)):

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
                self.count.set('结尾不能为算符')
            else:
                for length in range(0, len(self.inputlist)):
                    if str(self.inputlist[length]).isdigit():
                        self.midstr += str(self.inputlist[length])
                    else:
                        self.midstr = self.midstr + self.inputlist[length]
                self.inputCheck(self.midstr)
                print("中缀表达式为"+self.midstr)
                text = list(self.midstr)
                b = transfer(text)
                print("转换为后缀表达式" + "".join(b))
                c = get_post_express(b)
                print("结果为" + str(c))
                self.count.set(self.midstr + '=' + str(round(eval(self.midstr), 5)))
                self.inputlist = []
                self.midstr = ''
        else:
            self.addButton(button)

    def start(self):
        self.tk.mainloop()


class Daikuan(object):
    def __init__(self):
        super(Daikuan, self).__init__()
        self.daikuanTk = tkinter.Tk()
        self.daikuanTk.title('贷款计算器')
        self.daikuanTk.maxsize(400, 500)
        self.daikuanTk.minsize(400, 500)
        # 设置字体
        self.EntryFont = tkfont.Font(self.daikuanTk, size=11)
        self.ButtonFont = tkfont.Font(self.daikuanTk, size=12)
        self.checkNum = self.daikuanTk.register(self.validateNum)
        # 文字
        #  Label(self.daikuanTk, text='还款方式', font=("Arial,6")).place(x=30, y=10)
        Label(self.daikuanTk, text='贷款年限(年)', font=("Arial,6")).place(x=30, y=60)
        Label(self.daikuanTk, text='贷款金额(元)', font=("Arial,6")).place(x=30, y=120)
        Label(self.daikuanTk, text='贷款利率(月%)', font=("Arial,6")).place(x=30, y=180)
        Label(self.daikuanTk, text='月均还款(元)', font=("Arial,6")).place(x=30, y=300)
        Label(self.daikuanTk, text='利息总额(元)', font=("Arial,6")).place(x=30, y=360)
        Label(self.daikuanTk, text='还款总额(元)', font=("Arial,6")).place(x=30, y=420)
        # 选择框

        # 输出框
        self.monthCount = Label(self.daikuanTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.monthCount.place(x=190, y=300, width=200)

        self.rateCount = Label(self.daikuanTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.rateCount.place(x=190, y=360, width=200)

        self.rebackCount = Label(self.daikuanTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.rebackCount.place(x=190, y=420, width=200)

        # 输入框
        self.yearEntry = Entry(self.daikuanTk, validate='key', validatecommand=(self.checkNum, '%P'),
                               font=self.EntryFont)
        self.yearEntry.place(x=190, y=60)

        self.moneyEntry = Entry(self.daikuanTk, validate='key', validatecommand=(self.checkNum, '%P'),
                                font=self.EntryFont)
        self.moneyEntry.place(x=190, y=120)

        self.rateEntry = Entry(self.daikuanTk, validate='key', validatecommand=(self.checkNum, '%P'),
                               font=self.EntryFont)
        self.rateEntry.place(x=190, y=180)

        Button(self.daikuanTk, text='等额本息计算', bg='#66FFFF', font=self.ButtonFont, command=self.xcount).place(x=30,
                                                                                                             y=240,
                                                                                                             width=120,
                                                                                                             height=40)
        Button(self.daikuanTk, text='等额本金计算', bg='#66FFFF', font=self.ButtonFont, command=self.jcount).place(x=160,
                                                                                                             y=240,
                                                                                                             width=120,
                                                                                                             height=40)
        Button(self.daikuanTk, text='重新计算', bg='#FF0000', font=self.ButtonFont, command=self.recount).place(
            x=290, y=240, width=90, height=40)

    def xcount(self):
        money = int(self.moneyEntry.get())
        rate = int(self.rateEntry.get()) / 100
        year = int(self.yearEntry.get())
        ss = (money * rate * pow((1 + rate), year * 12)) / (pow(1 + rate, year * 12) - 1)
        self.monthCount['text'] = ss
        self.rateCount['text'] = ss * year * 12 - money
        # money*rate*(pow(1+rate, year*12)-pow(1+rate, year*12-1)/(pow(1+rate, year*12)-1))
        self.rebackCount['text'] = ss * 12 * year

    def jcount(self):
        money = int(self.moneyEntry.get())
        rate = int(self.rateEntry.get()) / 100
        year = int(self.yearEntry.get())
        ss = ((year * 12 + 1) * money * (rate / 12)) / 2
        self.monthCount['text'] = (ss + money) / (year * 12)
        self.rateCount['text'] = ss
        self.rebackCount['text'] = ss + money
        # 重新计算

    def recount(self):
        self.rateEntry.delete(0, END)
        self.moneyEntry.delete(0, END)
        self.yearEntry.delete(0, END)
        self.monthCount['text'] = ''
        self.rateCount['text'] = ''
        self.rebackCount['text'] = ''
        print("ok")

    def validateNum(self, content):
        if content.isdigit() and int(content) >= 0 or content == "":
            return True
        else:
            return False

    def start(self):
        self.daikuanTk.mainloop()


class Baoxian(object):
    """docstring for Baoxian"""

    def __init__(self):
        super(Baoxian, self).__init__()
        self.baoxianTk = tkinter.Tk()
        self.baoxianTk.title('基本养老保险金计算器')
        self.baoxianTk.maxsize(400, 500)
        self.baoxianTk.minsize(400, 500)
        # 字体设置
        self.EntryFont = tkfont.Font(self.baoxianTk, size=11)
        self.ButtonFont = tkfont.Font(self.baoxianTk, size=12)
        self.checkNum = self.baoxianTk.register(self.validateNum)
        Label(self.baoxianTk, text='您上年度平均月', font=("Arial,6")).place(x=15, y=10)
        Label(self.baoxianTk, text='工资(元)', font=("Arial,6")).place(x=20, y=35)
        Label(self.baoxianTk, text='本市职工上年度', font=("Arial,6")).place(x=20, y=70)
        Label(self.baoxianTk, text='平均月工资(元)', font=("Arial,6")).place(x=20, y=95)
        Label(self.baoxianTk, text='单位缴存比例(%)', font=("Arial,6")).place(x=20, y=140)
        Label(self.baoxianTk, text='个人缴存比例(%)', font=("Arial,6")).place(x=20, y=190)
        Label(self.baoxianTk, text='每月缴存基本', font=("Arial,6")).place(x=30, y=300)
        Label(self.baoxianTk, text='养老保险金(元)', font=("Arial,6")).place(x=30, y=325)
        Label(self.baoxianTk, text='单位缴存(元)', font=("Arial,6")).place(x=30, y=370)
        Label(self.baoxianTk, text='个人缴存(元)', font=("Arial,6")).place(x=30, y=420)
        self.yuecunCount = Label(self.baoxianTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.yuecunCount.place(x=190, y=310, width=200)
        self.danweiCount = Label(self.baoxianTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.danweiCount.place(x=190, y=370, width=200)
        self.gerenCount = Label(self.baoxianTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.gerenCount.place(x=190, y=420, width=200)
        self.selfEntry = Entry(self.baoxianTk, validate='key', validatecommand=(self.checkNum, '%P'),
                               font=self.EntryFont)
        self.selfEntry.place(x=190, y=20)
        self.shiEntry = Entry(self.baoxianTk, validate='key', validatecommand=(self.checkNum, '%P'),
                              font=self.EntryFont)
        self.shiEntry.place(x=190, y=80)
        self.danweiEntry = Entry(self.baoxianTk, validate='key', validatecommand=(self.checkNum, '%P'),
                                 font=self.EntryFont)
        self.danweiEntry.place(x=190, y=140)
        self.gerenEntry = Entry(self.baoxianTk, validate='key', validatecommand=(self.checkNum, '%P'),
                                font=self.EntryFont)
        self.gerenEntry.place(x=190, y=190)
        Button(self.baoxianTk, text='计算', bg='#66FFFF', font=self.ButtonFont, command=self.count).place(x=80, y=240,
                                                                                                        width=100,
                                                                                                        height=40)
        Button(self.baoxianTk, text='重新计算', bg='#FF0000', font=self.ButtonFont, command=self.recount).place(
            x=220, y=240, width=100, height=40)

    # 验证是否输入数字
    def validateNum(self, content):
        if content.isdigit() and int(content) >= 0 or content == "":
            return True
        else:
            return False

    # 计算
    def count(self):
        if int(self.selfEntry.get()) > int(self.shiEntry.get()) * 0.6 and int(self.selfEntry.get()) < int(
                self.shiEntry.get()) * 3:
            self.danweiCount['text'] = int(self.selfEntry.get()) * int(self.danweiEntry.get()) / 100
            self.gerenCount['text'] = int(self.selfEntry.get()) * int(self.gerenEntry.get()) / 100
            self.yuecunCount['text'] = int(self.selfEntry.get()) * int(self.danweiEntry.get()) / 100 + int(
                self.selfEntry.get()) * int(self.gerenEntry.get()) / 100
        elif int(self.selfEntry.get()) >= int(self.shiEntry.get()) * 3:
            self.danweiCount['text'] = int(self.shiEntry.get()) * 3 * int(self.danweiEntry.get()) / 100
            self.gerenCount['text'] = int(self.shiEntry.get()) * 3 * int(self.gerenEntry.get()) / 100
            self.yuecunCount['text'] = int(self.shiEntry.get()) * 3 * int(self.gerenEntry.get()) / 100 + int(
                self.shiEntry.get()) * 3 * int(self.danweiEntry.get()) / 100
        elif int(self.selfEntry.get()) <= int(self.shiEntry.get()) * 0.6:
            self.danweiCount['text'] = int(self.shiEntry.get()) * 0.6 * int(self.danweiEntry.get()) / 100
            self.gerenCount['text'] = int(self.shiEntry.get()) * 0.6 * int(self.gerenEntry.get()) / 100
            self.yuecunCount['text'] = int(self.shiEntry.get()) * 0.6 * int(self.gerenEntry.get()) / 100 + int(
                self.shiEntry.get()) * 3 * int(self.danweiEntry.get()) / 100
        else:
            pass

    # 重新计算
    def recount(self):
        self.selfEntry.delete(0, END)
        self.shiEntry.delete(0, END)
        self.danweiEntry.delete(0, END)
        self.gerenEntry.delete(0, END)
        self.danweiCount['text'] = ''
        self.gerenCount['text'] = ''
        self.yuecunCount['text'] = ''

    def start(self):
        self.baoxianTk.mainloop()


class Rate(object):
    """docstring for Baoxian"""

    def __init__(self):
        super(Rate, self).__init__()
        self.RateTk = tkinter.Tk()
        self.RateTk.title('利息计算器')
        self.RateTk.maxsize(400, 500)
        self.RateTk.minsize(400, 500)
        # 字体设置
        self.EntryFont = tkfont.Font(self.RateTk, size=11)
        self.ButtonFont = tkfont.Font(self.RateTk, size=12)
        self.checkNum = self.RateTk.register(self.validateNum)
        Label(self.RateTk, text='存入本金(元)', font=("Arial,6")).place(x=15, y=10)
        Label(self.RateTk, text='年利率(%)', font=("Arial,6")).place(x=20, y=70)
        Label(self.RateTk, text='存款周期(月)', font=("Arial,6")).place(x=20, y=150)
        Label(self.RateTk, text='利息总计(元)', font=("Arial,6")).place(x=20, y=300)
        Label(self.RateTk, text='本息合计(元)', font=("Arial,6")).place(x=20, y=380)
        self.lixiCount = Label(self.RateTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.lixiCount.place(x=190, y=300, width=200)
        self.benjinCount = Label(self.RateTk, bg='white', bd='3', fg='#8B795E', font=self.EntryFont)
        self.benjinCount.place(x=190, y=380, width=200)
        self.moneyEntry = Entry(self.RateTk, validate='key', validatecommand=(self.checkNum, '%P'),
                                font=self.EntryFont)
        self.moneyEntry.place(x=190, y=10)
        self.rateEntry = Entry(self.RateTk, validate='key', validatecommand=(self.checkNum, '%P'),
                               font=self.EntryFont)
        self.rateEntry.place(x=190, y=70)
        self.monthEntry = Entry(self.RateTk, validate='key', validatecommand=(self.checkNum, '%P'),
                                font=self.EntryFont)
        self.monthEntry.place(x=190, y=150)
        Button(self.RateTk, text='计算', bg='#66FFFF', font=self.ButtonFont, command=self.count).place(x=80, y=240,
                                                                                                     width=100,
                                                                                                     height=40)
        Button(self.RateTk, text='重新计算', bg='#FF0000', font=self.ButtonFont, command=lambda: self.recount()).place(
            x=220, y=240, width=100, height=40)

    # 验证是否输入数字
    def validateNum(self, content):
        if content.isdigit() and int(content) >= 0 or content == "":
            return True
        else:
            return False

    # 计算
    def count(self):
        a = int(self.moneyEntry.get()) * (int(self.rateEntry.get()) / 100) * (int(self.monthEntry.get()) / 12)
        b = a + int(self.moneyEntry.get())
        self.lixiCount['text'] = a
        self.benjinCount['text'] = b

    # 重新计算
    def recount(self):
        self.moneyEntry.delete(0, END)
        self.rateEntry.delete(0, END)
        self.monthEntry.delete(0, END)
        self.lixiCount['text'] = ''
        self.benjinCount['text'] = ''

    def start(self):
        self.RateTk.mainloop()


def startBaoxian():
    NewBaoxian = Baoxian()
    NewBaoxian.start()


def startDaikuan():
    NewDaiKuan = Daikuan()
    NewDaiKuan.start()


def startRate():
    NewRate = Rate()
    NewRate.start()


def transfer(list):
    priority = {'*': 3, '/': 3, '+': 2, '-': 2, '(': 1}
    post_list = []
    op_stack = []

    for i in list:
        if i in "+-*/":
            while op_stack and priority[op_stack[-1]] >= priority[i]:
                post_list.append(op_stack.pop())
            op_stack.append(i)
        elif i == "(":
            op_stack.append(i)
        elif i == ")":
            flag = op_stack.pop()
            while flag != "(":
                post_list.append(flag)
                flag = op_stack.pop()
        else:
            post_list.append(i)
    while op_stack:
        post_list.append(op_stack.pop())

    return post_list


def get_post_express(list):
    op_stack = []

    # 计算后缀表达式
    for i in list:
        if i in "+-*/":
            operand2 = op_stack.pop()
            operand1 = op_stack.pop()
            try:
                result = doMath(i, operand1, operand2)
                op_stack.append(result)
            except:
                return 'NAN'
        else:
            try:
                i = int(i)
            except:
                i = Fraction(i)
            op_stack.append(i)

    return op_stack.pop()


def doMath(op: str, number1, number2):
    if op == '+':
        return number1 + number2
    elif op == '-':
        return number1 - number2
    elif op == '*':
        return number1 * number2
    else:
        return Fraction(number1, number2)


if __name__ == '__main__':
    NewCalculator = Calculator()
    NewCalculator.start()
