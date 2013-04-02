<h1>天天打车 api</h1>

<h2>
  乘客注册(乘客端)
</h2>
<h3>
  url: <a href="/api/passengers/signup">/api/passengers/signup</a>
</h3>
<p>
参数：
name<br>
mobile<br>
lat<br>
lng<br>
password(MD5)<br>
iosDevice<br>
androidDevice<br>
</p>
<code>
curl -XPOST -d'passenger[name]=wanglei&passenger[mobile]=18600808686&passenger[password]=12345&passenger[iosDevice]=iosDevice&passenger[androidDevice]=androidDevice' http://127.0.0.1:3000/api/passengers/signup  <br>
{"passenger":{"androidDevice":"androidDevice","created_at":"2013-01-20T05:05:02Z","id":2,"iosDevice":"iosDevice","lat":null,"lng":null,"mobile":"18600808686","name":"wanglei","password":"12345","updated_at":"2013-01-20T05:05:02Z"}}
</code>
<hr/>


<h2>
  乘客获取验证码 (乘客端)
</h2>
<h3>
  url: <a href="/api/passengers/get_verification_code">/api/passengers/get_verification_code</a>
</h3>
<code>
curl -XGET -d'mobile=186008086843' http://localhost:3000/api/passengers/get_verification_code
{"code":"0"}
</code>
<hr/>

<h2>
  乘客登陆(乘客端)
</h2>
<h3>
  url: <a href="/api/passengers/signin">/api/passengers/signin</a>
</h3>
<code>
curl -XPOST -d'passenger[mobile]=18600808684&passenger[password]=12345' http://127.0.0.1:3000/api/passengers/signin <br>
{"created_at":"2013-01-11T16:29:04Z","id":1,"lat":null,"lng":null,"mobile":"18600808684","name":"wanglei","password":"12345","updated_at":"2013-01-11T16:29:04Z"}
</code>
<hr/>

<h2>
  乘客signout(乘客端)
</h2>
<h3>
  url: <a href="/api/passengers/signout">/api/passengers/signout</a>
</h3>
<code>
curl -XGET -d'passenger[iosDevice]=iosDevice' http://127.0.0.1:3000/api/passengers/signout
{"message":"logout success"}
</code>
<hr/>

<h2>
  司机注册(司机端)
</h2>
<h3>
  url: <a href="/api/drivers/signup">/api/drivers/signup</a>
</h3>
<p>
参数：<br>
name <br>
mobile<br>
lat<br>
lng<br>
password<br>
car_license<br>
car_type<br>
car_service_number<br>
rate<br>
androidDevice<br>
</p>
<code>
curl -XPOST -d'driver[name]=driver1&driver[mobile]=18600808684&driver[androidDevice]=androidDevice' http://127.0.0.1:3000/api/drivers/signup  <br>
{"androidDevice":"androidDevice","car_license":null,"car_service_number":null,"car_type":null,"created_at":"2013-01-20T05:07:02Z","id":2,"lat":null,"lng":null,"mobile":"18600808684","name":"driver1","password":null,"rate":null,"updated_at":"2013-01-20T05:07:02Z"}
</code>
<hr/>

<h2>
  司机update
</h2>
<h3>
  url: <a href="/api/drivers/:id">/api/drivers/:id</a>
</h3>
<p>
参数：
status
</p>
<code>
curl -XPOST -d'driver[status]=1' http://127.0.0.1:3000/api/drivers/1 <br>
{"driver":{"androidDevice":null,"car_license":"111","car_service_number":"111","car_type":"111","created_at":"2013-01-15T05:58:33Z","id":1,"lat":"39.915","lng":"116.405","mobile":"12222222","name":"siji1","online":0,"password":"1111","rate":1,"status":1,"updated_at":"2013-01-23T07:48:47Z"}}
</code>
<hr/>

<h2>
  司机登陆(司机端)
</h2>
<h3>
  url: <a href="/api/drivers/signin">/api/drivers/signin</a>
</h3>
<p>
参数：
mobile
password
</p>
<code>
curl -XPOST -d'driver[mobile]=18600808684&driver[password]=12345' http://127.0.0.1:3000/api/drivers/signin
this driver is not exist
</code>
<hr/>

<h2>
  司机signout(司机端)
</h2>
<h3>
  url: <a href="/api/drivers/signout">/api/drivers/signout</a>
</h3>
<p>
参数：
mobile
password
</p>
<code>
curl -XGET -d'driver[iosDevice]=iosDevice' http://127.0.0.1:3000/api/drivers/signout <br>
{"message":"logout success"}
</code>
<hr/>

<h2>
  获取我附近得司机(乘客端)
</h2>
<h3>
  url: <a href="/api/drivers">/api/drivers</a>
</h3>
<p>
请求参数：
</p>
<p>
driver[lat] 我的精度
</p>
<p>
driver[lng] 我的维度
</p>
<p>
scope 搜索范围(默认是5 可选)
</p>
<p>
示例：
</p>
<code>
curl -XGET -d'driver[iosDevice]=1&driver[androidDevice]=1&driver[lat]=39.876757965948&driver[lng]=116.65188108138' http://127.0.0.1:3002/api/drivers  <br>
[{"car_license":"1111","car_service_number":"111","car_type":"111","created_at":"2013-01-06T14:34:14Z","distance":0.5449183482818264,"id":1,"lat":"39.875078","lng":"116.641852","mobile":"13660405121","name":"driver1","password":"123456","rate":1,"updated_at":"2013-01-10T07:49:44Z"},
{"car_license":"1111","car_service_number":"1111","car_type":"1111","created_at":"2013-01-06T14:35:12Z","distance":0.5850274591311793,"id":2,"lat":"39.874635","lng":"116.662549","mobile":"18600808684","name":"driver2","password":"1111111","rate":1,"updated_at":"2013-01-10T07:50:00Z"}]
</code>
<hr/>

<h2>
  获取我附近得乘客(司机端)
</h2>
<h3>
  url: <a href="/api/passengers">/api/passengers</a>
</h3>
<p>
请求参数：
</p>
<p>
my_location_lat 我的精度
</p>
<p>
my_location_lng 我的维度
</p>
<p>
scope 搜索范围(默认是5 可选)
</p>
<p>
示例：
</p>
<code>
curl -XGET -d'passenger[id]=1&passenger[lat]=39.876757965948&passenger[lng]=116.65188108138' http://127.0.0.1:3002/api/passengers <br>
[{"created_at":"2013-01-08T02:00:47Z","distance":0.0,"id":1,"lat":"39.876757965948","lng":"116.65188108138","mobile":"18600808684","name":"wanglei","password":"123456","updated_at":"2013-01-10T07:51:19Z"}]
</code>
<hr/>

<h2>
  获取我附近得司机信息
</h2>
<h3>
  url: <a href="/api/drivers/{id}">/api/drivers/{id}</a>
</h3>
<p>
请求参数：
</p>
<p>
</p>
<p>
示例：
</p>
<code>
curl -XGET  http://127.0.0.1:3000/api/drivers/1 <br>
{"car_license":null,"car_service_number":null,"car_type":null,"created_at":"2013-01-12T14:52:21Z","id":1,"lat":null,"lng":null,"mobile":"18600808684","name":"driver1","password":null,"rate":null,"updated_at":"2013-01-12T14:52:21Z"}
</code>
<hr/>

<h2>
   路线
</h2>
<h3>
  url: <a href="/api/trips/{id}">/api/trips/{id}"</a>
</h3>
<p>
请求参数：
</p>
<p>
示例：
</p>
<code>
 curl -XGET http://127.0.0.1:3000/api/trips/1 <br>
 {"trip":{"appointment":"10","created_at":"2013-01-15T05:58:47Z","end":"shuangqiao","end_lat":null,"end_lng":null,"id":1,"passenger_id":1,"start":"tongzhou","start_lat":"39.915","start_lng":"116.405","updated_at":"2013-01-15T05:58:47Z"}}
</code>
<hr/>

<h2>
  发布路线【呼叫司机(5公里范围内)】
</h2>
<h3>
  url: <a href="/api/trips">/api/trips</a>
</h3>
<p>
请求参数：
<br>
trip[passenger_id]
<br>
trip[start]
<br>
trip[start_lat]
<br>
trip[start_lng]
<br>
trip[end]
<br>
trip[end_lat]<br>

trip[end_lng]<br>

trip[appointment]<br>

trip[price]<br>
</p>
<p>
示例：
</p>
<code>
curl -XPOST -d'trip[passenger_id]=1&trip[start]=tongzhou&trip[start_lat]=39.915&trip[start_lng]=116.405&trip[end]=shuangqiao&trip[appointment]=10' http://127.0.0.1:3000/api/trips <br>
{"trip":{"appointment":"10","created_at":"2013-01-16T05:19:32Z","end":"shuangqiao","end_lat":null,"end_lng":null,"id":2,"passenger_id":1,"start":"tongzhou","start_lat":"39.915","start_lng":"116.405","updated_at":"2013-01-16T05:19:32Z"}}
</code>
<hr/>



<h2>
我的会话（发送给我的请求）
</h2>
<h3>
url  <a href="/api/conversations">/api/conversations</a>
</h3>
<p>
请求参数：
to_id
</p>
<p>
示例：
</p>
<code>
curl -XGET -d'to_id=1' http://127.0.0.1:3000/api/conversations <br>
{"conversations":[{"content":"a passenger want a car","created_at":"2013-01-15T05:58:47Z","from_id":1,"id":1,"status":0,"status_desc":"new","to_id":1,"trip_id":1,"updated_at":"2013-01-15T05:58:47Z"},{"content":"a passenger want a car","created_at":"2013-01-16T05:19:32Z","from_id":1,"id":2,"status":0,"status_desc":"new","to_id":1,"trip_id":2,"updated_at":"2013-01-16T05:19:32Z"}]}
</code>
<hr/>

<h2>
更新会话状态 （接受，拒绝）
</h2>
<h3>
  url: <a href="/api/conversations/{id}">/api/conversations/{id}</a>
</h3>
<p>
请求参数：
conversation[status]   0-new 1-accept 2-reject
conversation[status_desc]  随便可以自己定义 例如 新请求  接受 拒绝
</p>
<p>
</p>
<p>
示例：
</p>
<code>
curl -XPUT -d'conversation[status]=1&conversation[status_desc]=accept' http://127.0.0.1:3000/api/conversations/1 <br>
{"conversation":{"content":"a passenger want a car","created_at":"2013-01-15T05:58:47Z","from_id":1,"id":1,"status":1,"status_desc":"accept","to_id":1,"trip_id":1,"updated_at":"2013-01-16T06:51:14Z"}}
</code>
<hr/>

