<template>
  <el-container style="width:100%;height:100%">
    <el-row type="flex" align="middle" justify="center" style="width:100%;height:100%">
      <el-row style="width:45%;height:95%;margin-top:50px" id="coinFactory" class="box11 shadow">
        <el-button style="margin-top:19%;margin-left:55%" circle @click="onCoinButtonClick">
          <div id="icon"></div>
        </el-button>
      </el-row>
    </el-row>
    <el-popover style="position:fixed;margin-top:30%;margin-left:70%" placement="bottom" :title="this.title" width="200"
      trigger="manual" :content="this.content" v-model="visible">
      <el-button style="display:none" slot="reference" @click="visible = !visible">手动激活</el-button>
    </el-popover>
    <el-row style="position:fixed;width:15%;height:35%;" class="board box2">
      <div id="ipad-icon"></div>
      <!-- <div>{{this.coinNumSelf}}</div> -->
      <div> </div>
      <div style="margin-top:50px">您现在所有的币总额：</div>
      <div class="iCountUp">
        <ICountUp :startVal="startVal" :endVal="this.coinNumSelf" :decimals="decimals" :duration="duration" :options="options"
          @ready="onReady" />
      </div>
      <div>目前的奖池总价值：</div>
      <div class="iCountUp">
        <ICountUp :startVal="startVal" :endVal="this.coinNumTotal" :decimals="decimals" :duration="duration" :options="options"
          @ready="onReady" />
      </div>
    </el-row>
  </el-container>
</template>

<style scoped>
  /* .board {
    background-color: rgba(250, 186, 11, 0.5);
    border-radius: 10px;
    margin-top: 10%;
    margin-left: 15%;
    border: 1px solid #a5b6c8;
    background: #eef3f7
  } */

  .box2 {
    margin-top: 10%;
    margin-left: 15%;
    /* margin: 20px auto; */
    width: 300px;
    min-height: 150px;
    padding: 10px;
    position: relative;
    background: -webkit-gradient(linear, 0% 20%, 0% 92%, from(#f5dca8), to(rgb(248, 247, 244)), color-stop(.1, #f5dca8));
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    -webkit-border-bottom-right-radius: 60px 60px;
    -webkit-box-shadow: -1px 2px 2px rgba(0, 0, 0, 0.2);
  }

  .box2:before {
    content: '';
    width: 25px;
    height: 20px;
    position: absolute;
    bottom: 0;
    right: 0;
    -webkit-border-bottom-right-radius: 30px;
    -webkit-box-shadow: -2px -2px 5px rgba(0, 0, 0, 0.3);
    -webkit-transform:
      rotate(-20deg) skew(-40deg, -3deg) translate(-13px, -13px);
  }

  /* .box2:after {
    content: '';
    z-index: -1;
    width: 100px;
    height: 100px;
    position: absolute;
    bottom: 0;
    right: 0;
    background: rgba(0, 0, 0, 0.2);
    display: inline-block;
    -webkit-box-shadow: 20px 20px 8px rgba(0, 0, 0, 0.2);
    -webkit-transform: rotate(0deg) translate(-45px, -20px) skew(20deg);
  } */

  .el-button {
    background-color: rgba(231, 174, 17, 0.8);
  }

  #icon {
    background-image: url('../assets/南瓜.png');
    background-size: cover;
    width: 25px;
    height: 25px;
  }

  #ipad-icon {
    background-image: url('../assets/p1.png');
    background-size: cover;
    width: 120%;
    height: 50px;
    margin-left: -10%;
    margin-top: -10%;
  }

  .el-container {
    background-image: url('../assets/back.png');
    background-size: cover;
    z-index: 1000;
    overflow: hidden;
  }

  .box11 {
    background-image: url('../assets/factory.png');
    background-size: cover;

    width: 400px;
    height: 100px;
    /* background: #ccc; */
    border-radius: 10px;
    margin: 10px;
    z-index: 0;
  }

  .iCountUp {
    font-size: 36px;
    margin: 0;
    color: #ff6600;
  }
</style>

<script>
  import anime from 'animejs'
  import ICountUp from 'vue-countup-v2';
  export default {
    name: 'home',
    components: {
      ICountUp
    },
    data() {
      return {
        startVal: 0,
        endVal: 120500,
        decimals: 0,
        duration: 2.5,
        lowerBound: 50,
        upperBound: 60,
        options: {
          useEasing: true,
          useGrouping: true,
          separator: ',',
          decimal: '.',
          prefix: '',
          suffix: ''
        },
        coinNumSelf: 10,
        coinNumTotal: 1000,
        ENUM: {
          ing: 0,
          success: 1,
          fail: 2,
          zero: 3,
          start: 4,
        },
        visible: true,
        content: '这是一段内容,这是一段内容,这是一段内容,这是一段内容。',
        title: '标题',
        titles: ['赌博ing', '大爆发！', '咦，只是一次手气不好啦。', '妈呀，小脸煞黑！', '欢迎来到BitRun推币机～'],
        contents: ['22娘正在为您紧张推币，请耐心等待。', '22娘为您背回了推得的币：'+this.winEvent._amount , '22娘向非洲人发射同情的目光。', '您输光了您手上所有的币，建议您洗个脸再来。',
          '头发不会掉小组为您服务～万圣节快乐哦～🎃'
        ],
      }
    },
    methods: {
      onReady: function(instance, CountUp) {
        const that = this;
        // instance.update(that.endVal + 100);
      },
      contratTest() {
        return true;
      },
      set22Text(ENUM) {
        this.title = this.titles[ENUM];
        this.content = this.contents[ENUM];
      },
      onCoinButtonClick() {
      this.winEvent = null
      this.pending = true
      this.$store.state.contractInstance().bet( {
        gas: 300000,
        from: this.$store.state.web3.coinbase
      }, (err, result) => {
        if (err) {
          console.log(err)
          this.pending = false
        } else {
          let Won = this.$store.state.contractInstance().Won()
          Won.watch((err, result) => {
            if (err) {
              console.log('could not get event Won()')
            } else {
              this.winEvent = result.args
              this.pending = false
              console.log(winEvent._amount)
            }
          })
        }
      })

      
      },
      dropCoin() {
        var random = Math.random() * 100;
        if (random > this.lowerBound && random <= this.upperBound) {
          continue
        }
        else {
          continue
        }
      },

    },
    created() {
      this.set22Text(this.ENUM.start);
      var myHollowClick = function () {
        var click_cnt = 0;
        var $html = document.getElementsByTagName("html")[0];
        var $body = document.getElementsByTagName("body")[0];
        var texts = ['富强', '民主', '文明', '和谐', '自由', '平等', '公正', '法治', '爱国', '敬业', '诚信', '友善', '❤'];
        var colors = ['#FF0000', '#9F5F9F', ' #B5A642', '#5F9F9F', '#238E23'];
        $html.onclick = function (e) {
          var $elem = document.createElement("b");
          $elem.style.color = "#E94F06";
          $elem.style.zIndex = 9999;
          $elem.style.position = "absolute";
          $elem.style.select = "none";
          var x = e.pageX;
          var y = e.pageY;
          $elem.style.left = (x - 10) + "px";
          $elem.style.top = (y - 20) + "px";
          clearInterval(anim);
          let click_cnt_text = click_cnt % texts.length;
          // let click_cnt_color = click_cnt % colors.length;
          $elem.innerText = texts[click_cnt_text];
          click_cnt++;
          $elem.style.fontSize = '16px'
          var increase = 0;
          var anim;
          setTimeout(function () {
            anim = setInterval(function () {
              if (++increase == 150) {
                clearInterval(anim);
                $body.removeChild($elem);
              }
              $elem.style.top = y - 20 - increase + "px";
              $elem.style.opacity = (150 - increase) / 120;
            }, 8);
          }, 70);
          $body.appendChild($elem);
        };
      };

      myHollowClick();
    }
  }
</script>