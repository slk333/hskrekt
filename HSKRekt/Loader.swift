import UIKit
import CoreData

class Loader{

    init(){
        
    
        
        
        let defaults = UserDefaults.standard
        let isLoaded = defaults.bool(forKey: "isLoaded")
        let hasHSK2 = defaults.bool(forKey: "hasHSK2")
     

        let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        

        /*
         isLoaded=false
         let fetchRequest=NSFetchRequest<Mot>(entityName:"Mot")
         let array3=try! context.fetch(fetchRequest)
         for t in array3{
         context.delete(t)
         }
         */
        
        
        
        let s1="爱@八@爸爸@杯子@北京@本@不@不客气@菜@茶@吃@出租车@打电话@大@的@点@电脑@电视@电影@东西@都@读@对不起@多@多少@儿子@二@饭馆@飞机@分钟@高兴@个@工作@狗@汉语@好@喝@和@很@后面@回@会@火车站@几@家@叫@今天@九@开@看@看见@块@来@老师@了@冷@里@零@六@妈妈@吗@买@猫@没@没关系@米饭@明天@名字@哪@哪儿@那@那儿@呢@能@你@年@女儿@朋友@漂亮@苹果@七@钱@前面@请@去@热@人@认识@日@三@商店@上@上午@少@谁@什么@十@时候@是@书@水@水果@睡觉@说话@四@岁@他@她@太@天气@听@同学@喂@我@我们@五@喜欢@下@下午@下雨@先生@现在@想@小@小姐@些@写@谢谢@星期@学生@学习@学校@一@衣服@医生@医院@椅子@有@月@在@再见@怎么@怎么样@这@这儿@中国@中午@住@桌子@字@昨天@做@坐@近@就@觉得@咖啡@开始@考试@可能@可以@刻@快@快乐@累@比@离@两@路@旅游@别@卖@慢@忙@每@妹妹@门@男人@您@牛奶@女人@旁边@跑步@便宜@票@妻子@起床@千@晴@去年@让@上班@长@身体@生病@生日@时间@唱歌@事情@手表@手机@送@所以@它@踢足球@题@出@跳舞@外@玩@完@晚上@为什么@问@问题@西瓜@希望@洗@穿@向@小时@笑@船@新@姓@休息@雪@次@颜色@眼睛@羊肉@药@要@也@从@已经@一起@意思@阴@因为@游泳@右边@鱼@错@元@远@运动@再@早上@张@丈夫@找@着@真@正在@知道@打篮球@准备@自行车@走@最@左边@大家@但是@到@得@等@弟弟@地址@吧@懂@对@白@房间@非常@服务员@高@百@告诉@哥哥@给@公共汽车@公斤@公司@帮助@贵@过@还@孩子@好吃@号@报纸@黑@红@欢迎@回答@机场@鸡蛋@件@教室@姐姐@介绍@进"
        let s2="ai4@ba1@ba4 ba5@bei1 zi5@bei3 jing1@ben3@bu4@bu4 ke4 qi5@cai4@cha2@chi1@chu1 zu1 che1@da3 dian4 hua4@da4@de5@dian3@dian4 nao3@dian4 shi4@dian4 ying3@dong1 xi5@dou1@du2@dui4 bu5 qi3@duo1@duo1 shao3@er2 zi5@er4@fan4 guan3@fei1 ji1@fen1 zhong1@gao1 xing4@ge4@gong1 zuo4@gou3@han4 yu3@hao3@he1@he2@hen3@hou4 mian5@hui2@hui4@huo3 che1 zhan4@ji3@jia1@jiao4@jin1 tian1@jiu3@kai1@kan4@kan4 jian4@kuai4@lai2@lao3 shi1@le5@leng3@li3@ling2@liu4@ma1 ma5@ma5@mai3@mao1@mei2@mei2 guan1 xi5@mi3 fan4@ming2 tian1@ming2 zi5@na3@na3 er5@na4@na4 er5@ne5@neng2@ni3@nian2@nv3 er2@peng2 you5@piao4 liang5@ping2 guo3@qi1@qian2@qian2 mian5@qing3@qu4@re4@ren2@ren4 shi5@ri4@san1@shang1 dian4@shang4@shang4 wu3@shao3@shei2@shen2 me5@shi2@shi2 hou5@shi4@shu1@shui3@shui3 guo3@shui4 jiao4@shuo1 hua4@si4@sui4@ta1@ta1@tai4@tian1 qi4@ting1@tong2 xue2@wei2@wo3@wo3 men5@wu3@xi3 huan5@xia4@xia4 wu3@xia4 yu3@xian1 sheng5@xian4 zai4@xiang3@xiao3@xiao3 jie5@xie1@xie3@xie4 xie5@xing1 qi1@xue2 sheng5@xue2 xi2@xue2 xiao4@yi1@yi1 fu5@yi1 sheng1@yi1 yuan4@yi3 zi5@you3@yue4@zai4@zai4 jian4@zen3 me5@zen3 me5 yang4@zhe4@zhe4 er5@Zhong1 guo2@zhong1 wu3@zhu4@zhuo1 zi5@zi4@zuo2 tian1@zuo4@zuo4@jin4@jiu4@jue2 de5@ka1 fei1@kai1 shi3@kao3 shi4@ke3 neng2@ke3 yi3@ke4@kuai4@kuai4 le4@lei4@bi3@li2@liang3@lu4@lv3 you2@bie2@mai4@man4@mang2@mei3@mei4 mei5@men2@nan2 ren2@nin2@niu2 nai3@nv3 ren2@pang2 bian1@pao3 bu4@pian2 yi5@piao4@qi1 zi5@qi3 chuang2@qian1@qing2@qu4 nian2@rang4@shang4 ban1@chang2@shen1 ti3@sheng1 bing4@sheng1 ri4@shi2 jian1@chang4 ge1@shi4 qing5@shou3 biao3@shou3 ji1@song4@suo3 yi3@ta1@ti1 zu2 qiu2@ti2@chu1@tiao4 wu3@wai4@wan2@wan2@wan3 shang5@wei4 shen2 me5@wen4@wen4 ti2@xi1 gua1@xi1 wang4@xi3@chuan1@xiang4@xiao3 shi2@xiao4@chuan2@xin1@xing4@xiu1 xi5@xue3@ci4@yan2 se4@yan3 jing5@yang2 rou4@yao4@yao4@ye3@cong2@yi3 jing1@yi4 qi3@yi4 si5@yin1@yin1 wei4@you2 yong3@you4 bian5@yu2@cuo4@yuan2@yuan3@yun4 dong4@zai4@zao3 shang5@zhang1@zhang4 fu5@zhao3@zhe5@zhen1@zheng4 zai4@zhi1 dao4@da3 lan2 qiu2@zhun3 bei4@zi4 xing2 che1@zou3@zui4@zuo3 bian5@da4 jia1@dan4 shi4@dao4@de5@deng3@di4 di5@di4 zhi3@ba5@dong3@dui4@bai2@fang2 jian1@fei1 chang2@fu2 wu4 yuan2@gao1@bai3@gao4 su5@ge1 ge5@gei3@gong1 gong4 qi4 che1@gong1 jin1@gong1 si1@bang1 zhu4@gui4@guo4@hai2@hai2 zi5@hao3 chi1@hao4@bao4 zhi3@hei1@hong2@huan1 ying2@hui2 da2@ji1 chang3@ji1 dan4@jian4@jiao4 shi4@jie3 jie5@jie4 shao4@jin4"
        
        let s3="Love@Eight@Dad,Daddy,Papa@A cup,A glass@Beijing (Capital of China)@Measure Word for the word `book(s)`  @No , Not , Does not@You're welcome!@(food) Dish , Course@Tea@To eat@Taxi@To make a phonecall,To call someone (by phone)@Big@Possessive and Attributive Particule@O'clock@A Computer@Television@Movie@A Thing,Stuff,Something@Used after a plural, meaning `all` (eg: 他们都是.. = They (all) are..)@To read@Sorry !@Many, A lot@How many／How much@Son@Two@Restaurant@Airplane@Minute@Joyful , Delighted , Glad , Happy@General Measure Word@To Work , A Job@Dog@Chinese (The language)@Good@To drink@And@Very , (link,word between subject and adjective)@Behind@Return,Go back@Can, be able to@Train (火车) station (站）@1) How many 2) A few@1) Family 2) Home @1) To be named XXX 2) To call someone (not on phone)@Today@Nine@Open@To look,To look at @To see,To catch sight of ..@1 ¥ = 1 Yuan = 1 Kuai@to Come@Teacher@verb+了 = completed action , past tense marker@Cold@In,Inside@Zero@Six@Mom,Mummy,Mother@? (Question tag)@Buy@Cat@Negation word (similar to 不), usually used with 有@it doesn't matter@rice@Tomorrow@Name@Which one ?@Where@That (same as 这, but for distant things)@There , Over there@1) used as 你呢 to ask question back 2) Style effect@To be able,capable (similar to 会) , Can possibly@You@Year@Daughter@Friend@Pretty; beautiful@Apple@Seven@Money@In front of , Ahead@1) To ask 2) Please@Go@Hot@Person , People@To know someone@`Day` in expression like : 2013 5月 31日 (in writing)@Three@Shop@On , Above@Morning@A little , Few , Less (contrary of 多)@Who@What@Ten@Time , Moment@Be@Book@Water@Fruit@Sleep@To say , To talk , To speak@Four@X Years old @He@She@Too@Weather@Listen@Classmate@Hello ? (in phone)@I@We@Five@Like@Under , Below , After@Afternoon@Rain@Mister@Now@To Want (more polite than 要).@Small , Little@Miss@Some, Several, A few (used as 一些+noun）@Write@Thanks@Week@Student@Study@School@One@Clothes@Doctor@Hospital@Chair@Have@Month@1) At,In  2) 在+Verb = Verb+ing (action is lasting)@Goodbye , See you !@How@1) How is (was) it ? 2) Suggestion marker@This@Here@China@Noon@To Live in@Table@A Character@Yesterday@To do@To sit@not far, close, near@1) then, in that case 2) at once, right away 3) just (emphasis) 4) as early, already, as soon as@1) to think that 2) to feel (tired)@coffee, CL:杯[bei1]@to begin, to start, the beginning,  CL:个[ge4]@exam, CL:次[ci4]@might (happen), possible, probable, possibility, probability, maybe, perhaps, CL:個|个[ge4]@can, may, possible, able to@a quarter (hour)@1) rapid, quick, 2) soon, almost, @happy, merry@tired@particle used for comparison, to express -er than @1) to leave (离开) 2） when giving distance : from (here to ..)@two (when talking about the quantity of something)@road, path, way, CL:条[tiao2]@to travel, for travel@1) 别的.. other (things, people) 2) 别+V don't .. (an order) @to sell@slow@busy@each, every@younger sister@a door, a gate@a man, a male, men, CL:个[ge4]@you (polite form, as opposed to informal 你[ni3])@milk (cow's milk)@a woman, a female, women@side, beside@to run@cheap, inexpensive@ticket CL:张[zhang1]@wife@to get up (from bed)@thousand@(weather) clear, fine (not cloudy)@last year@1) to let (somebody do something) 2) let's + suggestion@1) to go to work 2) be on duty, be at work @long@1) body, 2) health@to fall ill, to get sick@birthday@1) time, period of time 2) How long 多长时间@to sing a song@affair, matter, thing, CL:件[jian4]@a watch, often simply said 表 biao3 CL:块[kuai4]@cell phone, mobile phone, CL:部[bu4]@1) to deliver, to carry, 2) to give (as a present) 3) to see off, to send@so, therefore, as a result @it@play soccer(football)@topic, subject, problem for discussion, exam question@to go out, to come out@to dance@outside (something), outside 外面, other 另外, foreigner 外国人@to have hun@to finish, to complete, be over@in the evening, at night@why@to ask@question, problem, issue, topic@watermelon, CL:条[tiao2]@to hope that, to wish for, to desire@to wash, to bathe@to wear, to put on (clothes or shoes)@to, towards, in the direction of@hour, CL:个[ge4]@to laugh, to smile@a boat, a ship, CL:条[tiao2]@new@family name, surname, to be named@rest, to rest@snow, snowfall, 下雪 it's snowing@time : 三次 three times, 下次 next time, 上次 last time@color@eye, eyes@mutton (meat)@medicine, drug CL:种[zhong3]@1) to want 2) it is necessary to.. (imperative, essential) 3) it's going to@also, too@1) (preposition) from (a time, a place) 2) through@already@together@1) meaning 2) 有意思 it's interesting @overcast (sky, weather), covered by clouds@because@to swim@right side, right, to the right@a fish, CL:条[tiao2]@1) to make a mistake, to get wrong 2) a mistake, a fault@Chinese money unit 一元 = 1 Yuan@far, distant, remote@sport, 做运动 to do sport@1) again, once more 2）.. only then ..(after sth and not until then)@early morning@classifier for flat objects, like tickets, paper sheet, bed, table@husband@1) to look for, try to find 2) to want to see someone 3) to give change@particle attached after verb to indicate action in progress like -ing ending@real, true (真的) @正在+Verb = in the process of (doing something)@to know@to play basketball@1) to prepare, preparation 2) to get ready@bicycle, bike CL:辆[liang4]@1) to walk 2) to go, to leave, to go away@most, the most, -est@left, the left side, to the left of@everybody, everyone@but@1) to (a place), until (a time) 2) to arrive@used after verb to indicate effect, degree, possibility@to wait for@younger brother@address@(modal particle indicating polite suggestion), ...right?, ...OK?@to understand@1) right, correct 2) with regard to, concerning, to@white (color) (白色)@room, CL:间[jian1]@1) very, extremely 2) unusual, extraordinary@waiter, waitress, attendant@high, tall@hundred@to tell@older brother@1) to give 2) for (somebody) 我给你买东西 lit: for you I buy something@bus, CL:辆[liang4]@kilogram (kg)@company@to help, to assist@1) expensive 2) precious@1) verb+过 = accomplished action 2) to cross (street) 3) to celebrate (a holiday) @1) still 2) in addition, also@child@tasty, delicious@1) day of the month number, eg 8th = 八号 2) number@newspaper CL:份[fen4]@black (color) 黑色@red (color) 红色@to welcome, welcome@to reply, to answer@airport@an egg (chicken)@measure word for some things, affairs, clothes, or furnitures@classroom, CL:间[jian1]@older sister@to introduce (somebody to someone)@to enter"
        
        let s4="0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0@0"
        let s5="1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000@1000000000"
        
             let s6="我爱你 I love you@八点 8 AM/PM@他是我的爸爸 He is my dad@一杯水 A glass of water 一杯茶 A cup of tea (we omit 子)@北 = North, 京 = Capital. Capital of the North@一本书 One book@我不要 I don't want@, 谢谢 , 不客气 Thanks , You're welcome @这个菜很好吃 This dish tastes very good@一杯茶 A cup of tea@你想吃什么 What do you want to eat@坐出租车 Take a taxi@给我打电话 Call me (on phone)@很大的房子@我的名字 My name@三点 3 AM/PM@你有没有电脑 Do you have a computer ?@看电视 Watch TV@看电影 Watch a movie@这个东西 This thing@他们都很高兴 They are all very happy@她喜欢读书 She likes to read books 你读一下 You read a bit@真对不起！I'm really sorry !@很多人 A lot of people .. @多少钱 How much is it ? 多少年 How many years ?@他是我的儿子 He is my son@一二三 one two three @一个小饭馆 A little restaurant@坐飞机 Take plane@七分钟 Seven minutes@他很高兴 He is very happy/joyful@一个东西 One thing 这个东西 This thing@你喜欢工作吗 Dou you like to work ?@一只狗 A dog (MW: 只 zhi1)@我学汉语 I learn Chinese@很好的学校 A good school@你要喝水吗 Do you want (to drink) some water ?@你和我 You and me@我很好，谢谢 I'm (very) good, thanks@在我后面 Behind me@回家 Go back home 我回来了 I'm back !@你会说中文吗 Can you speak Chinese ?@在火车站，有很多火车 At the train station, there are a lot of trains.@1) 你有几个弟弟？How many little brothers do you have ? 2) 我买了几本书 I bought some books@1) 我的家很大 My family is very big 2) 回家 Come back home@我叫John。My name is John. 2) 叫他 call him !@我今天去学校 Today, i go to school.@九年 Nine years@开门 Open the door / (for shop) 什么时候开门 When does (the shop) open ?@看一下！ Look !@你看见了吗 You saw it ?@多少钱？七块 ！How much is it ? Seven kuai ! (roughly USD 1$)@你来吧！Come ! 你什么时候来看我 When do you come to see me ?@很好的老师 A good teacher@我到了 ！I arrived @这里很冷！It's very cold here !@房子里 Inside the house@零零七 007@六岁 Six years old@妈妈！Mummy !@你喜欢吗 You like ? (吗 is always at the end of the sentence)@你想买什么 What do you want to buy ?@一只猫 A cat (MW: 只 zhi1 for animals with claws)@有没有苹果？没有。Are there some apples ? No, there is not. 我没有 I don't have.@没关系，没关系 ! It's okay, It's okay !@我喜欢吃米饭 I like to eat rice@你明天做什么 What do you do tomorrow@你的名字是什么 What's your name ?@你有水吗 Do you have some water ? 我没有 I don't have. 没有人 There is nobody  @他在哪儿 ？Where is he ?@那个东西 That thing@她在那儿！She is over there !@我很好，你呢？ I'm good, and you ?@我不能.. I'm not able to.. 你今天能来吗 ？Can you possibly come tonight ?@你是谁？Who are you ? / 你们 = plural you 你们做什么 What are you guys doing ?@五年 Five years 明年 Next year@她是我的女儿 She is my daughter@我有很多朋友 I have many friends@她很漂亮 She is very pretty@买苹果 Buy some apples@上午七点 7 AM@有钱 Rich@在房子的前面 In front of the house 我前面有两人 There are two people in front of me@1）你可以请我 You can ask me 2) 请坐 Please seat@你去哪儿？Where are you going ?@今天很热 It's very hot today@人太多/有太多人 There are too many people.@你认识她吗 You know her ?@九月一日 September 1 st@三个朋友 Three friends@这个商店很大 This shop is very big@桌子上 On the table@今天上午 Today morning@很少 Not a lot 少吃 Eat less@她是谁 Who is she ?@你在做什么 What are you doing@十分钟就到了 I'll be here in 10 minutes (lit: 10 minutes then i'm arrived)@什么时候 When (lit: What time) 你什么时候去吧@他是我的弟弟 He is my little brother@一本书 A book@一杯水 A glass of water@多吃水果 ! Eat more fruits !@我要睡觉 I want to sleep@ 你在说什么 ? What are you saying ? 你会说汉语吗 ? Can you speak Chinese ?@四年 Four years @十八岁 Eighteen years old@他是我的儿子 He is my son@她是我的女儿 She is my daughter@太多！ Too many ! 太高 ！Too tall@今天天气很好 The weather today is very good@听我一下 Listen to me 听音乐 Listen to music@你有多少同学 @喂 ？听我妈 Hello ? You hear me ?@我要去中国 I want to go to China@我们去喝茶吧 Let's go to have a tea ! (lit: We go to drink a tea ok ?)@五个人 Five people@我很喜欢你！ I like you very much !@桌子下 Under the table@下午八点 8 PM@下雨了 ！It's raining !@Wang 先生 Mister Wang (Name goes before)@我现在去吃饭 ！I go to eat now !@你想去哪儿 ? Where do you want to go ?@小猫 Little cat 小孩子 Little children@王小姐 Miss Wang (name goes first)@一些东西 Some things 一些苹果 Some apples.@你会不会写汉语？Can you write Chinese ?@谢谢! Thanks!/Thank you!@星期一 Monday 什么星期 ？Which week ?@在学校，有很多学生 At school, there are a lot of students@你喜欢学习吗 Do you like to study ?@你的学校很大！Your school is very big !@一个分钟 One minute@白色的衣服 White color clothes. 好看的衣服 Good looking clothes@看医生 See a doctor@我要去医院 I want to go to the hospital@坐在椅子上 Sit on the chair@你有，我没有 You have,  I don't have.@一个月 One month 一月 January@她在哪儿 Where is she ? 她在做什么 What is he doing ?@再见！ Bye ! See you again ! /  (lit: 再 again + 见 see)@你怎么这么高？ How are you so tall ? 怎么做？ How to do ?@1) 天气怎么样？ How is the weather today ? 2) 我们去中国怎么样? What do you think about going to China ？（lit: We go to China, how is it?)@这个东西 This thing 这本书 This book@这儿，什么都没有！ There is nothing here ! 来这儿吧 ! Come here !@中国很大 China is very big@中午吃饭 Eat at noon@你住在哪儿 Where do you live in ?@桌子上 On the table @一个汉字 A Chinese character@我昨天买了衣服 I bought some clothes yesterday@你在做什么 What are you doing ?@请坐 Please have a sit (lit: please sit) 你想坐在哪儿 Where do you want to sit ?@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@N/A@"
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let a1=s1.components(separatedBy: "@")
        let a2=s2.components(separatedBy: "@")
        let a3=s3.components(separatedBy: "@")
        let a4=s4.components(separatedBy: "@")
        let a5=s5.components(separatedBy: "@")
        let a6=s6.components(separatedBy: "@")
       
       
        if isLoaded == false{
        
        for i in 0..<303{
            _=Mot(index: i, character: a1[i], pinyin: a2[i], definition: a3[i], score: Int(a4[i])!, date: Double(a5[i])!,exemple:a6[i],insertInto: context)
        }
        
        
        try! context.save()
        
        defaults.set(true, forKey: "isLoaded")
       defaults.set(true, forKey: "hasHSK2")
              // print("loaded once and for all")
        }
        
        
        
       else if hasHSK2 == false{
            for i in 153..<303{
                _=Mot(index: i, character: a1[i], pinyin: a2[i], definition: a3[i], score: Int(a4[i])!, date: Double(a5[i])!,exemple:a6[i],insertInto: context)
            }
            
            
            try! context.save()
            
            defaults.set(true, forKey: "hasHSK2")
        
           // print("loaded HSK2 once and for all")
        
        }
        
        
        
     











    }

}
