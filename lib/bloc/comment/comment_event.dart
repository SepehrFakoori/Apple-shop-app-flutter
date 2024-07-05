abstract class CommentEvent {}

class CommentInitialEvent extends CommentEvent {
  String productId;

  CommentInitialEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  String productId;
  String comment;

  CommentPostEvent(this.productId, this.comment);
}
