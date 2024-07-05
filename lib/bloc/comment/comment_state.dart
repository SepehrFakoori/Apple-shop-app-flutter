import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/model/comment.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, List<Comment>> response;

  CommentResponseState(this.response);
}

class CommentPostLoadingState extends CommentState {
  final bool isLoading;

  CommentPostLoadingState(this.isLoading);
}

class CommentPostResponseState extends CommentState {
  final Either<String, String> response;

  CommentPostResponseState(this.response);
}
