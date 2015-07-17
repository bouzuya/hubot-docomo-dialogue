// Description
//   A Hubot script that calls the docomo dialogue API
//
// Dependencies:
//   None
//
// Configuration:
//   HUBOT_DOCOMO_DIALOGUE_P
//   HUBOT_DOCOMO_DIALOGUE_API_KEY
//
// Commands:
//   * - calls the docomo dialogue API
//
// Author:
//   bouzuya <m@bouzuya.net>
//
module.exports = function(robot) {
  robot.brain.data.dialogue = {};
  return robot.hear(/.*/, function(res) {
    var ctx, p, payload, ref, room_id;
    p = parseFloat((ref = process.env.HUBOT_DOCOMO_DIALOGUE_P) != null ? ref : '0.3');
    if (!(Math.random() < p)) {
      return;
    }
    payload = {
      utt: res.match[0],
      nickname: res.message.user.name
    };
    room_id = res.message.user.reply_to || res.message.user.room;
    if (ctx = robot.brain.data.dialogue[room_id]) {
      payload.context = ctx.context;
      payload.mode = ctx.mode;
    }
    return res.http('https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue').header('Content-Type', 'application/json').query({
      APIKEY: process.env.HUBOT_DOCOMO_DIALOGUE_API_KEY
    }).post(JSON.stringify(payload))(function(err, _, body) {
      var data;
      if (err != null) {
        robot.logger.error(e);
        return res.send('docomo-dialogue: error');
      } else {
        data = JSON.parse(body);
        res.send(data.utt);
        return robot.brain.data.dialogue[room_id] = {
          context: data.context,
          mode: data.mode
        };
      }
    });
  });
};
