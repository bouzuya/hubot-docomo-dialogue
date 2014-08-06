# Description
#   A Hubot script that calls the docomo dialogue API
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_DOCOMO_DIALOGUE_P
#   HUBOT_DOCOMO_DIALOGUE_API_KEY
#
# Commands:
#   * - calls the docomo dialogue API
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.hear /.*/, (res) ->
    p = parseFloat(process.env.HUBOT_DOCOMO_DIALOGUE_P ? '0.3')
    return unless Math.random() < p
    message = res.match[0]
    res
      .http 'https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue'
      .header 'Content-Type', 'application/json'
      .query APIKEY: process.env.HUBOT_DOCOMO_DIALOGUE_API_KEY
      .post(JSON.stringify({ utt: message })) (err, _, body) ->
        if err?
          robot.logger.error e
          res.send 'docomo-dialogue: error'
        else
          res.send JSON.parse(body).utt
