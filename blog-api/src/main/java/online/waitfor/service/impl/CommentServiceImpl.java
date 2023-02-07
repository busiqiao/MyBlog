package online.waitfor.service.impl;

import online.waitfor.model.dto.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import online.waitfor.exception.PersistenceException;
import online.waitfor.mapper.CommentMapper;
import online.waitfor.model.vo.PageComment;
import online.waitfor.service.CommentService;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * @Description: 博客评论业务层实现
 * @Author: Naccl
 * @Date: 2020-08-03
 */
@Service
public class CommentServiceImpl implements CommentService {
	@Autowired
	CommentMapper commentMapper;

	@Override
	public List<online.waitfor.entity.Comment> getListByPageAndParentCommentId(Integer page, Long blogId, Long parentCommentId) {
		List<online.waitfor.entity.Comment> comments = commentMapper.getListByPageAndParentCommentId(page, blogId, parentCommentId);
		for (online.waitfor.entity.Comment c : comments) {
			//递归查询子评论及其子评论
			List<online.waitfor.entity.Comment> replyComments = getListByPageAndParentCommentId(page, blogId, c.getId());
			c.setReplyComments(replyComments);
		}
		return comments;
	}

	@Override
	public List<PageComment> getPageCommentList(Integer page, Long blogId, Long parentCommentId) {
		List<PageComment> comments = getPageCommentListByPageAndParentCommentId(page, blogId, parentCommentId);
		for (PageComment c : comments) {
			List<PageComment> tmpComments = new ArrayList<>();
			getReplyComments(tmpComments, c.getReplyComments());
			//对于两列评论来说，按时间顺序排列应该比树形更合理些
			//排序一下
			Comparator<PageComment> comparator = Comparator.comparing(PageComment::getCreateTime);
			tmpComments.sort(comparator);

			c.setReplyComments(tmpComments);
		}
		return comments;
	}

	@Override
	public online.waitfor.entity.Comment getCommentById(Long id) {
		online.waitfor.entity.Comment comment = commentMapper.getCommentById(id);
		if (comment == null) {
			throw new PersistenceException("评论不存在");
		}
		return comment;
	}

	/**
	 * 将所有子评论递归取出到一个List中
	 *
	 * @param comments
	 */
	private void getReplyComments(List<PageComment> tmpComments, List<PageComment> comments) {
		for (PageComment c : comments) {
			tmpComments.add(c);
			getReplyComments(tmpComments, c.getReplyComments());
		}
	}

	private List<PageComment> getPageCommentListByPageAndParentCommentId(Integer page, Long blogId, Long parentCommentId) {
		List<PageComment> comments = commentMapper.getPageCommentListByPageAndParentCommentId(page, blogId, parentCommentId);
		for (PageComment c : comments) {
			List<PageComment> replyComments = getPageCommentListByPageAndParentCommentId(page, blogId, c.getId());
			c.setReplyComments(replyComments);
		}
		return comments;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void updateCommentPublishedById(Long commentId, Boolean published) {
		//如果是隐藏评论，则所有子评论都要修改成隐藏状态
		if (!published) {
			List<online.waitfor.entity.Comment> comments = getAllReplyComments(commentId);
			for (online.waitfor.entity.Comment c : comments) {
				hideComment(c);
			}
		}

		if (commentMapper.updateCommentPublishedById(commentId, published) != 1) {
			throw new PersistenceException("操作失败");
		}
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void updateCommentNoticeById(Long commentId, Boolean notice) {
		if (commentMapper.updateCommentNoticeById(commentId, notice) != 1) {
			throw new PersistenceException("操作失败");
		}
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void deleteCommentById(Long commentId) {
		List<online.waitfor.entity.Comment> comments = getAllReplyComments(commentId);
		for (online.waitfor.entity.Comment c : comments) {
			delete(c);
		}
		if (commentMapper.deleteCommentById(commentId) != 1) {
			throw new PersistenceException("评论删除失败");
		}
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void deleteCommentsByBlogId(Long blogId) {
		commentMapper.deleteCommentsByBlogId(blogId);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void updateComment(online.waitfor.entity.Comment comment) {
		if (commentMapper.updateComment(comment) != 1) {
			throw new PersistenceException("评论修改失败");
		}
	}

	@Override
	public int countByPageAndIsPublished(Integer page, Long blogId, Boolean isPublished) {
		return commentMapper.countByPageAndIsPublished(page, blogId, isPublished);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void saveComment(Comment comment) {
		if (commentMapper.saveComment(comment) != 1) {
			throw new PersistenceException("评论失败");
		}
	}

	/**
	 * 递归删除子评论
	 *
	 * @param comment 需要删除子评论的父评论
	 */
	private void delete(online.waitfor.entity.Comment comment) {
		for (online.waitfor.entity.Comment c : comment.getReplyComments()) {
			delete(c);
		}
		if (commentMapper.deleteCommentById(comment.getId()) != 1) {
			throw new PersistenceException("评论删除失败");
		}
	}

	/**
	 * 递归隐藏子评论
	 *
	 * @param comment 需要隐藏子评论的父评论
	 */
	private void hideComment(online.waitfor.entity.Comment comment) {
		for (online.waitfor.entity.Comment c : comment.getReplyComments()) {
			hideComment(c);
		}
		if (commentMapper.updateCommentPublishedById(comment.getId(), false) != 1) {
			throw new PersistenceException("操作失败");
		}
	}

	/**
	 * 按id递归查询子评论
	 *
	 * @param parentCommentId 需要查询子评论的父评论id
	 * @return
	 */
	private List<online.waitfor.entity.Comment> getAllReplyComments(Long parentCommentId) {
		List<online.waitfor.entity.Comment> comments = commentMapper.getListByParentCommentId(parentCommentId);
		for (online.waitfor.entity.Comment c : comments) {
			List<online.waitfor.entity.Comment> replyComments = getAllReplyComments(c.getId());
			c.setReplyComments(replyComments);
		}
		return comments;
	}
}
