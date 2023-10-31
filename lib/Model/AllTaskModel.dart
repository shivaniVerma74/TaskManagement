class AllTaskModel {
  bool? error;
  String? message;
  String? totalTasks;
  List<TaskDataList>? data;

  AllTaskModel({this.error, this.message, this.totalTasks, this.data});

  AllTaskModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    totalTasks = json['total_tasks'];
    if (json['data'] != null) {
      data = <TaskDataList>[];
      json['data'].forEach((v) { data!.add(new TaskDataList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['total_tasks'] = this.totalTasks;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskDataList {
  String? id;
  String? workspaceId;
  String? projectId;
  String? userId;
  String? milestoneId;
  String? title;
  String? description;
  String? priority;
  String? taskType;
  String? dueDate;
  String? status;
  String? createdBy;
  Null? assignedTo;
  String? class1;
  String? commentCount;
  String? startDate;
  String? dateCreated;
  List<Comments>? comments;
  List<TaskFile>? file;
  String? taskCreator;
  List<String>? users;

  TaskDataList({this.id, this.workspaceId, this.projectId, this.userId, this.milestoneId,
    this.title, this.description, this.priority, this.taskType, this.dueDate, this.status, this.createdBy, this.assignedTo, this.class1, this.commentCount, this.startDate, this.dateCreated, this.comments, this.file, this.taskCreator, this.users});

  TaskDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workspaceId = json['workspace_id'];
    projectId = json['project_id'];
    userId = json['user_id'];
    milestoneId = json['milestone_id'];
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    taskType = json['task_type'];
    dueDate = json['due_date'];
    status = json['status'];
    createdBy = json['created_by'];
    assignedTo = json['assigned_to'];
    class1 = json['class'];
    commentCount = json['comment_count'];
    startDate = json['start_date'];
    dateCreated = json['date_created'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) { comments!.add(new Comments.fromJson(v)); });
    }
    if (json['file'] != null) {
      file = <TaskFile>[];
      json['file'].forEach((v) { file!.add(new TaskFile.fromJson(v)); });
    }
    taskCreator = json['task_creator'];
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workspace_id'] = this.workspaceId;
    data['project_id'] = this.projectId;
    data['user_id'] = this.userId;
    data['milestone_id'] = this.milestoneId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['task_type'] = this.taskType;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['assigned_to'] = this.assignedTo;
    data['class'] = this.class1;
    data['comment_count'] = this.commentCount;
    data['start_date'] = this.startDate;
    data['date_created'] = this.dateCreated;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.file != null) {
      data['file'] = this.file!.map((v) => v.toJson()).toList();
    }
    data['task_creator'] = this.taskCreator;
    data['users'] = this.users;
    return data;
  }
}

class Comments {
  String? id;
  String? workspaceId;
  String? projectId;
  String? taskId;
  String? userId;
  String? comment;
  String? dateCreated;
  String? isRead;
  String? username;

  Comments({this.id, this.workspaceId, this.projectId, this.taskId, this.userId, this.comment, this.dateCreated, this.isRead, this.username});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workspaceId = json['workspace_id'];
    projectId = json['project_id'];
    taskId = json['task_id'];
    userId = json['user_id'];
    comment = json['comment'];
    dateCreated = json['date_created'];
    isRead = json['is_read'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workspace_id'] = this.workspaceId;
    data['project_id'] = this.projectId;
    data['task_id'] = this.taskId;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['date_created'] = this.dateCreated;
    data['is_read'] = this.isRead;
    data['username'] = this.username;
    return data;
  }
}

class TaskFile {
  String? id;
  String? workspaceId;
  String? typeId;
  String? userId;
  String? type;
  String? originalFileName;
  String? fileName;
  String? fileExtension;
  String? fileSize;
  String? dateCreated;

  TaskFile({this.id, this.workspaceId, this.typeId, this.userId, this.type, this.originalFileName, this.fileName, this.fileExtension, this.fileSize, this.dateCreated});

  TaskFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workspaceId = json['workspace_id'];
    typeId = json['type_id'];
    userId = json['user_id'];
    type = json['type'];
    originalFileName = json['original_file_name'];
    fileName = json['file_name'];
    fileExtension = json['file_extension'];
    fileSize = json['file_size'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workspace_id'] = this.workspaceId;
    data['type_id'] = this.typeId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['original_file_name'] = this.originalFileName;
    data['file_name'] = this.fileName;
    data['file_extension'] = this.fileExtension;
    data['file_size'] = this.fileSize;
    data['date_created'] = this.dateCreated;
    return data;
  }
}