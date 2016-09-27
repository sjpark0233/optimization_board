package ldcc.board.api;

import com.google.api.services.drive.model.File;

public class GoogleFile {
	private String id;
	private String name;
	private String parentId;
	private boolean isFile;
	private long size;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public static GoogleFile parse(File file) {
		GoogleFile googleFile = new GoogleFile();
		googleFile.setId(file.getId());
		googleFile.setName(file.getName());
		googleFile.setParentId(file.getParents() != null ? file.getParents().get(0) : null);
		googleFile.setFile(!file.getMimeType().equals("application/vnd.google-apps.folder"));
		googleFile.setSize(googleFile.isFile() ? file.getSize() : 0L);
		return googleFile;
	}
}
