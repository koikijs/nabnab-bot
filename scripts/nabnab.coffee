test = room: "C217B7QG0" # test
mode = 'normal'
envelope = room: "C0JHEPQ94" # general

module.exports = (robot) ->

  # error handling
  robot.error (err, res) ->
    robot.logger.error err
    robot.logger.error res

  # startup
  robot.send envelope, '!!!'
  setTimeout () ->
    msgs = JSON.parse(robot.brain.get('msgs')||'[]')
    message = msgs[Math.floor(Math.random() * msgs.length)] || ''
    robot.send test, message
  , 5000

  # probability ... number, 0%~100%
  sendReaction = (msg, probability) ->
    randomInt = Math.floor(Math.random() * ((100/probability)*5))
    switch randomInt
      when 0
        msg.send "!!!"
      when 1
        msg.send "！"
      when 2
        msg.send "おー"
      when 3
        msg.send "あー"
      when 4
        msg.send "おお"
      else

  robot.hear /.*/, (msg) ->
    sendReaction msg, 20

  robot.hear /(ナブチ|なぶち)(|さん|様)/, (msg) ->
    sendReaction msg, 100

  robot.hear /ナブチ様　起きてください　デス/, (msg) ->
    msg.send "!!!"