import 'package:ecommerce_flutter_application/bloc/comment/comment_event.dart';
import 'package:ecommerce_flutter_application/bloc/comment/comment_state.dart';
import 'package:ecommerce_flutter_application/data/repository/comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentLoadingState()) {
    on<CommentInitialEvent>((event, emit) async {
      final response = await commentRepository.getComments(event.productId);
      emit(CommentResponseState(response));
    });

    on<CommentPostEvent>((event, emit) async {
      emit(CommentPostLoadingState(true));
      await commentRepository.postComment(event.productId, event.comment);
      emit(CommentPostLoadingState(false));
      emit(CommentLoadingState());
      final response = await commentRepository.getComments(event.productId);
      emit(CommentResponseState(response));
    });
  }
}
