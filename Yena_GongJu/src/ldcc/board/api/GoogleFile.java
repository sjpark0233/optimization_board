package ldcc.board.api;

import com.google.api.services.drive.model.File;

public class GoogleFile {
	private String id;
	private String title;
	private String parentId;
	private boolean isFile;
	private long fileSize;
	private String webContentLink;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String name) {
		this.title = name;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public boolean isFile() {
		return isFile;
	}

	public void setFile(boolean isFile) {
		this.isFile = isFile;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long size) {
		this.fileSize = size;
	}

	public String getWebContentLink() {
		return webContentLink;
	}

	public void setWebContentLink(String webContentLink) {
		this.webContentLink = webContentLink;
	}

	public static GoogleFile parse(File file) {		
		GoogleFile googleFile = new GoogleFile();
		googleFile.setId(file.getId());
		googleFile.setTitle(file.getTitle());
		googleFile.setParentId(file.getParents() != null && file.getParents().size() > 0 ? file.getParents().get(0).getId() : null);
		googleFile.setFile(!file.getMimeType().equals("application/vnd.google-apps.folder"));
		googleFile.setFileSize(googleFile.isFile() ? file.getFileSize() : 0L);
		googleFile.setWebContentLink(file.getWebContentLink() != null ? file.getWebContentLink() : null);
		return googleFile;
	}
}
