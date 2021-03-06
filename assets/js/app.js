// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

// adapted from nat's notes
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/14-assoc-and-ajax/notes.html

function update_buttons() {
  $('.manager-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let manager = $(bb).data('manager');
    if (manager != "") {
      $(bb).text("Remove as manager");
    } else {
      $(bb).text("Add as manager");
    }
  });

  $('.managee-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let managee = $(bb).data('managee');
    if (managee != "") {
      $(bb).text("Remove as managee");
    } else {
      $(bb).text("Add as managee");
    }
  });

  $('.working-button').each( (_, bb) => {
    let task_id = $(bb).data('task-id');
    let timeblock = $(bb).data('timeblock');
    if (timeblock != "") {
      $(bb).text("Stop working");
    } else {
      $(bb).text("Start working");
    }
  });
}


function set_manager_button(user_id, value) {
  $('.manager-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('manager', value);
    }
  });
  update_buttons();
}

function set_managee_button(user_id, value) {
  $('.managee-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('managee', value);
    }
  });
  update_buttons();
}


function set_working_button(task_id, value) {
  $('.working-button').each( (_, bb) => {
    if (task_id == $(bb).data('task-id')) {
      $(bb).data('timeblock', value);
    }
  });
  update_buttons();
}

function add_manager(user_id) {
  let text = JSON.stringify({
    manager: {
      manager_id: user_id,
      managee_id: current_user_id
    }
  });

  $.ajax(manager_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      set_manager_button(user_id, resp.data.id);
      location.reload();
    }
  });
}

function remove_manager(user_id, manage_id) {
  $.ajax(manager_path + "/" + manage_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => {
      set_manager_button(user_id, "");
      location.reload();
    }
  });
}

function add_managee(user_id) {
  let text = JSON.stringify({
    manager: {
      manager_id: current_user_id,
      managee_id: user_id
    }
  });

  $.ajax(manager_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      set_managee_button(user_id, resp.data.id);
      location.reload();
    }
  });
}

function remove_managee(user_id, manage_id) {
  $.ajax(manager_path + "/" + manage_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => {
      set_managee_button(user_id, "");
      location.reload();
    }
  });
}

function start_timeblock(task_id) {
  let text = JSON.stringify({
    timeblock: {
      task_id: task_id,
    }
  });

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      set_working_button(task_id, resp.data.id); 
      location.reload();
    }
  });
}

function stop_timeblock(task_id, timeblock_id) {
  let text = JSON.stringify({
    timeblock: {
      end: null
    }
  });
  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "patch",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: () => {
      set_working_button(task_id, "");
      location.reload();
    }
  });
}

function manager_click(ev) {
  let btn = $(ev.target);
  let manage_id = btn.data('manager')
  let user_id = btn.data('user-id');

  if (manage_id != "") {
    remove_manager(user_id, manage_id)
  } else {
    add_manager(user_id);
  }
}

function managee_click(ev) {
  let btn = $(ev.target);
  let manage_id = btn.data('managee')
  let user_id = btn.data('user-id');

  if (manage_id != "") {
    remove_managee(user_id, manage_id)
  } else {
    add_managee(user_id);
  }
}

function working_click(ev) {
  let btn = $(ev.target);
  let task_id = btn.data('task-id')
  let timeblock_id = btn.data('timeblock');

  if (timeblock_id != "") {
    stop_timeblock(task_id, timeblock_id)
  } else {
    start_timeblock(task_id);
  }
}

function init_manage() {
  if (!$('.manager-button')) {
    return
  }

  $('.manager-button').click(manager_click);
  $('.managee-button').click(managee_click);
  update_buttons();
}

function init_working() {
  if (!$('.working-button')) {
    return
  }

  $('.working-button').click(working_click);
  update_buttons();
}

$(init_manage);
$(init_working);
