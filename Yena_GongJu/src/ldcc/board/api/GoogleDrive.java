package ldcc.board.api;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.Drive.Files;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;

import ldcc.board.DriveQuickstart;

public class GoogleDrive {
	/** Application name. */
	private static final String APPLICATION_NAME = "Drive API Java Quickstart";

	/** Directory to store user credentials for this application. */
	private static final java.io.File DATA_STORE_DIR = new java.io.File(System.getProperty("user.home"),
			".credentials/drive-java-quickstart");

	/** Global instance of the {@link FileDataStoreFactory}. */
	private static FileDataStoreFactory DATA_STORE_FACTORY;

	/** Global instance of the JSON factory. */
	private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();

	/** Global instance of the HTTP transport. */
	private static HttpTransport HTTP_TRANSPORT;

	/**
	 * Global instance of the scopes required by this quickstart.
	 *
	 * If modifying these scopes, delete your previously saved credentials at
	 * ~/.credentials/drive-java-quickstart
	 */
	private static final List<String> SCOPES = Arrays.asList(DriveScopes.DRIVE_METADATA_READONLY);

	static {
		try {
			HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
			DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
		} catch (Throwable t) {
			t.printStackTrace();
			System.exit(1);
		}
	}

	/**
	 * Creates an authorized Credential object.
	 * 
	 * @return an authorized Credential object.
	 * @throws IOException
	 */
	private Credential authorize() throws IOException {
		// Load client secrets.
		InputStream in = DriveQuickstart.class.getResourceAsStream("client_secret.json"); // ÀÌ°Å
		GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

		// Build flow and trigger user authorization request.
		GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY,
				clientSecrets, SCOPES).setDataStoreFactory(DATA_STORE_FACTORY).setAccessType("offline").build();

		Credential credential = new AuthorizationCodeInstalledApp(flow, new LocalServerReceiver()).authorize("user");
		return credential;
	}

	private Drive getDriveService() throws IOException {
		Credential credential = authorize();
		return new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential).setApplicationName(APPLICATION_NAME).build();
	}

	private static List<GoogleFile> getListAll() throws IOException {
		Drive service = new GoogleDrive().getDriveService();
		List<GoogleFile> googleFileList = new ArrayList<GoogleFile>();
		Files.List request = service.files().list().setFields("files(id, name, parents, size, spaces, mimeType)");
		do {
			try {
				FileList files = request.execute();
				for (File file : request.execute().getFiles()) {
					googleFileList.add(GoogleFile.parse(file));
				}
				request.setPageToken(files.getNextPageToken());
			} catch (IOException e) {
				System.out.println("An error occurred: " + e);
				request.setPageToken(null);
			}
		} while (request.getPageToken() != null && request.getPageToken().length() > 0);

		return googleFileList;
	}

	private static String getRootId() throws IOException {
		List<GoogleFile> googleFileList = getListAll();
		String rootId = null;

		for (GoogleFile googleFile : googleFileList) {
			if (new GoogleDrive().getDriveService().files().get(googleFile.getParentId()).setFields("parents").execute()
					.getParents() == null) {
				rootId = googleFile.getParentId();
				break;
			}
		}

		return rootId;
	}

	public static List<GoogleFile> getFileList(String parentId) throws IOException {
		List<GoogleFile> googleFileList = new ArrayList<GoogleFile>();

		for (GoogleFile googleFile : getListAll()) {
			if (googleFile.getParentId().equals(parentId)) {
				googleFileList.add(googleFile);
			}
		}

		return googleFileList;
	}

	public static List<GoogleFile> getFileListOfRoot() throws IOException {
		return getFileList(getRootId());
	}

	public static GoogleFile getFile(String id) throws IOException {
		for (GoogleFile googleFile : getListAll()) {
			if (googleFile.getId().equals(id)) {
				return googleFile;
			}
		}

		return null;
	}
}
