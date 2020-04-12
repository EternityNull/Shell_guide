#!/bin/bash
# 如果是sh xxx.sh则这句声明无效

# echo "hello world"
# echo hello world
# ----以上二者等效


# echo "$(ls)"
# echo '$(ls)'
# 单引号''里面的变量 命令均失效

# echo `ls` # 这一句反引号则直接作为命令执行

# m="aaa bbb   ccc"
# echo $m
# echo "$m"
# 第一种方式会改格式，最好使用第二种

# echo -n "aaa" # 这种方式echo之后不换行
# echo ""
# echo "aaaa\nbbbb"
# echo -e "aaa\nbbb" # 这种其中可以使用转义斜线\

# 如果变量和常量之前需要区分边界
# xa="hello"
# echo "${xa}world"

# unset xa
# echo "$xa" # unset 之后变量不存在，值得注意的是 未声明定义变量 $之后为空，如下所示
# echo "$xd" # 注 unset不能删除只读变量

# 声明只读变量
# xb="hello"
# readonly xb

# 截取字符串
# str="hello"
# echo "${#str}" # 输出长度
# echo "${str:2:4}" # 从index 1 开始截取 4个长度
# echo `expr index "$str" e` # 查找e字符出现的index位置，结果 + 1


# echo $# # 参数个数
# echo $0 # 当前脚本名
# echo "$*" # 传递的所有参数作为一个字符串 $1 $2 $3 ...
# echo $@ # 与上面区别在于作为三个参数

# for i in "$*"
# do
#     echo $i # 这里只循环了一次
# done

# for i in "$@"
# do
#     echo $i # 这里循环了三次
# done

# echo $$ # 当前进程ID
# echo $! # 代表最后执行的后台命令的PID
# echo $? # 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。


##############  shell 数组  #################
# shell 只支持一维数组

# arr=(21 1 2 3)
# arr[8]=5  # 会发现有空的元素  8 变为了 4
# echo ${arr[@]} # 可以获取所有元素，这里{}不可少 且不可""
# echo ${arr[*]} # 可以获取所有元素，这里{}不可少 且不可""
# # 遇事不决 加上{}

# echo ${#arr[@]}
# echo ${#arr[*]} # 和上面等价
# echo ${#arr[0]} # 弱类型 输出2


########## 运算 ############
# val=`expr 2 \* 2` # 注意空格不能少，且乘号前加转移斜杠
# echo `expr 2+2` # 这里直接输出了“2+2”
# echo "$val"
# echo $((2 + 2)) # 这样也可以甚至更好

# 数字运算符 -eq 等于 -ne 不等于 -gt 大于 -lt 小于 -ge 大于等于 -le 小于等于

# if [ 10 -eq 10 ]
# then echo 1
# fi

# a=10
# b=10
# echo "$a -eq $b" # 这样是不行的 判断语句需要在[]中

# 字符串运算符 = != -z -n
# $ 检测是否为空
# a="abc"
# if [ "$a" != "abc" ]
# then
#     echo "y"
# fi

# if [ -z "$a" ]
# then
#     echo "y" # 长度是否为0；-n 长度是否不为0
# fi

############ 文件测试

##############

# echo "\"It is a \n test\"" # 这种转义双引号的不加-e也可以，\n则不行
# echo -e "it \t aa"
# echo -e "OK \nHHH\c"  # \n换行 \c关闭echo自动换行


# 可以使用printf来输出 更强大
# printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg
# printf "%-10s %-8s %-4.2f\n" A 男 66.1234
# printf "%-10s %-8s %-4.2f\n" B 男 48.6543
# printf "%-10s %-8s %-4.2f\n" C 女 47.9876
# printf 不会自动换行需要加\n  - 表示左对齐  10个字符宽度

# num1=100
# num2=200
# if test $num1 -eq $[num2 - 100]  # []可以进行运算
# then
#     echo "y"
# fi

# if test "aa" = "aa"
# then
#     echo "y"
# fi

# if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true"; fi # 一行模式

# if true
# then
#     echo "a"
# elif false
# then
#     echo "b"
# else
#     echo "c"
# fi

###### 循环语句 #####
# v=(1 2 3)
# for var in $v # 这种方式不可行
# for var in ${v[*]}
# do
#     echo -e "$var \c"
# done

# i=0
# while [ $i -lt ${#v[@]} ] # < 在这里不可用
# do
#     echo ${v[$i]}
#     let i++
# done


# for file in `ls`
for file in $(ls)  # 两种都可以
do
    echo ${file}
done

# for ((var; var < ${#v[*]}; var ++)) # (())也可以
# do
#     echo -e "${v[var]} \c"
# done

# i=0
# while ((i < ${#v[*]}))
# do
#     echo ${v[$i]}
#     let i++
#     # break  # 可以使用break结束循环
# done

############## let命令 用于执行计算 #########
# let a=5+4 # 赋值等号不能有空格 且不需要$符号
# let a++
# echo $a

# aNum=1
# case $aNum in
#     1)  echo '1'
#     ;;  # 两个分号表示break
#     2)  echo '2'
#     ;;
#     3)  echo '3'
#     ;;
#     4)  echo '4'
#     ;;
#     *)  echo 'n'
#     ;;
# esac

################### 函数  ###############
# fun() {
#     echo `expr $1 + $2`
# }
# fun 1 2   # 用这种方式来传参

# 输入输出重定向
# echo "AAA" > file # 覆盖  会自动创建文件
# echo "BBB" >> file # 追加
# echo > /dev/null 2>&1 # 常用 屏蔽stdin stderr &1的含义就可以理解为用标准输出的引用，引用的就是重定向标准输出产生打开的a。

# 文件引用
# . ./xxx.sh
# # 或者
# source ./xxx.sh


# let i='1+2' # 单引号 且变量不需要$符号
# i=$((1+2))  # $(())只是整数运算 不能调用命令
# echo $i